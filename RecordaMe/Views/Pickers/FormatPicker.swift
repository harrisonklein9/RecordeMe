//
//  PickerVIew.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/24/20.
//

import SwiftUI
import AVFoundation

struct FormatPicker: View {
    
    @ObservedObject var recorder: RecorderPlayer
    @Binding var showActionSheet: Bool
    @State var selectedFormat: String = "AAC"
    
    let formats = [("AAC", kAudioFormatMPEG4AAC), ("Linear PCM", kAudioFormatLinearPCM), ("IMA4", kAudioFormatAppleIMA4), ("MP3", kAudioFormatMPEGLayer3), ("AC-3", kAudioFormatAC3)]
    
    var body: some View {
        VStack {
        Text(selectedFormat)
            .bold()
            .foregroundColor(.black)
            .onTapGesture(perform: {
                self.showActionSheet = true
            })
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Choose Audio Format"), buttons: getButtons())
            }
        }
    }
    
    func getButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button]! = []
        
        for i in 0..<formats.count {
            buttons.append(.default(Text(formats[i].0)) {
                recorder.formatId = formats[i].1
                selectedFormat = formats[i].0
                
            })
        }
        
        return buttons
        
    }
}


