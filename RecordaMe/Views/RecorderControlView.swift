//
//  RecorderControlView.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/24/20.
//

import SwiftUI

struct RecorderControlView: View {
    
    @ObservedObject var recorder: RecorderPlayer
    @State var decibelLevel: CGFloat = 1.0
    
    @Binding var darkModeEnabled: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                
            }) {
                Circle()
                    .frame(width: 50, height: 50, alignment: .center)
                    .scaleEffect(CGFloat(decibelLevel))
                    .foregroundColor(.red)
                    .onTapGesture(perform: {
                        if recorder.isRecording {
                            recorder.finishRecording()
                        }
                        else {
                            recorder.startRecording()
                            setDecibel()
                        }
                    })
            }

        }
    }
    
    func setDecibel() {
        Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
            self.decibelLevel = self.getDecibel()
            
            if !recorder.isRecording {
                return
            }
        }
    }
    
    func getDecibel() -> CGFloat {
        
        if recorder.audioRecorder != nil {
            recorder.audioRecorder.updateMeters()
            print(recorder.audioRecorder.averagePower(forChannel: 0))

            let multiplier = 1 + pow(10, (0.05 * recorder.audioRecorder.averagePower(forChannel: 0)))
            
            let cgFloat = CGFloat(multiplier)
            
            return cgFloat

        }
        return 1
    }

}

