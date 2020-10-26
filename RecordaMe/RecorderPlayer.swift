//
//  RecorderHelper.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/24/20.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class RecorderPlayer: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate, ObservableObject {
    
    let objectWillChange = PassthroughSubject<RecorderPlayer, Never>()
    
    var isRecording = false {
        didSet {
            DispatchQueue.main.async {

                self.objectWillChange.send(self)
            }
        }
    }
    
    var isPlaying = false {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send(self)
            }
        }
    }
    
    var recordings = [Recording]()
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    var formatId: AudioFormatID!
    var sampleRate: Int!
    var encoderQuality: Int!
    var pcmLinearDepth: Int!
    
    override init() {
        super.init()
        
        self.formatId = kAudioFormatMPEG4AAC
        self.sampleRate = 44100
        self.encoderQuality = AVAudioQuality.high.rawValue
        self.pcmLinearDepth = 16
        
        setRecordings()

    }
    
    init(formatId: AudioFormatID, sampleRate: Int, encoderQuality: Int, pcmLinearDepth: Int? = 16) {
        self.formatId = formatId
        self.sampleRate = sampleRate
        self.encoderQuality = encoderQuality
        self.pcmLinearDepth = pcmLinearDepth

    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupSession(_ session: AVAudioSession, success: @escaping (Bool) -> ()) {
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            session.requestRecordPermission { (permission) in
                if permission {
                    success(true)
                }
                else {
                    success(false)
                }
            }
            
        }
        catch {
            success(false)
        }
    }
    
    func startRecording() {
        
        let session = AVAudioSession.sharedInstance()
        
        self.setupSession(session) { (success) in
            if success {
                
                var settings: [String: Any] = [
                    AVFormatIDKey: Int(self.formatId),
                    AVSampleRateKey: self.sampleRate!,
                    AVNumberOfChannelsKey: 1,
                    AVEncoderAudioQualityKey: self.encoderQuality!
                ]
                
                if self.formatId == kAudioFormatLinearPCM {
                    settings[AVLinearPCMBitDepthKey] = self.pcmLinearDepth
                }
                
                let randomId = UUID().uuidString
                
                guard let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    return
                }
                
                let audioFilename = documentPath.appendingPathComponent("\(randomId).\(AVFileType.caf.rawValue)")
                
                do {
                    self.audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                    self.audioRecorder.isMeteringEnabled = true
                    self.audioRecorder.delegate = self
                    self.audioRecorder.record()
                    self.isRecording = true
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func finishRecording() {
        audioRecorder.stop()
        audioRecorder = nil
        isRecording = false
    }
    
    func playRecording(_ url: URL) {
        
        
        let session = AVAudioSession.sharedInstance()
        try? session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.caf.rawValue)
            audioPlayer?.play()
            isPlaying = true
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getLowestIndex() -> Int {
        let ids = recordings.map({$0.id})
        let set = Set(ids)
        var i = 0
        
        while i >= 0 {
            if !set.contains(i) {
                return i
            }
            
            i += 1
        }
        return 0
    }
    
    
    func setRecordings() {
        
        if let recordingsData = UserDefaults.standard.data(forKey: "recordings") {
            if var values = try? JSONDecoder().decode([Recording].self, from: recordingsData) {
                values = values.sorted(by: { $0.id < $1.id})
                recordings = values
                objectWillChange.send(self)
            }
            else {
                recordings = []
            }
        }
        
        else {
            recordings = []
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        let lowestIndex = getLowestIndex()

        let recording = Recording(location: recorder.url, title: "New Recording \(lowestIndex)", id: lowestIndex, dateCreated: Date())
        
        recordings.append(recording)
        
        if let recordingData = try? JSONEncoder().encode(recordings) {
            UserDefaults.standard.set(recordingData, forKey: "recordings")
            UserDefaults.standard.synchronize()
        }
        
        objectWillChange.send(self)
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
}
