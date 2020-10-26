//
//  QualityPicker.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/25/20.
//

import SwiftUI
import AVFoundation

struct QualityPicker: View {
    
    
    @ObservedObject var recorder: RecorderPlayer
    @Binding var showActionSheet: Bool
    @State var selectedQuality: String = "High"
    let qualities = [("Max", AVAudioQuality.max.rawValue), ("High", AVAudioQuality.high.rawValue), ("Medium", AVAudioQuality.medium.rawValue), ("Low", AVAudioQuality.low.rawValue)]
    
    
    var body: some View {
        VStack {
        Text(selectedQuality)
            .bold()
            .foregroundColor(.black)
            .onTapGesture(perform: {
                self.showActionSheet = true
            })
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Choose Encoder Quality"), buttons: getButtons())
            }
        }
    }
    
    func getButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button]! = []
        
        for i in 0..<qualities.count {
            buttons.append(.default(Text(qualities[i].0)) {
                recorder.encoderQuality = qualities[i].1
                selectedQuality = qualities[i].0
            })
        }
        
        return buttons
        
    }
}

