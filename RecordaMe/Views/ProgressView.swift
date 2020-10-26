//
//  ProgressView.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/24/20.
//

import SwiftUI

struct ProgressView: View {
    
    @ObservedObject var recorder: RecorderPlayer
    @State var barWidthPercentage: Float = 0.0
    
    @Binding var progress: Float
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                if recorder.isPlaying {
                    Rectangle().frame(width: geo.size.width * CGFloat(barWidthPercentage), height: geo.size.height).foregroundColor(.blue).onAppear(perform: { self.updateBarWidth() })
                }
            }.cornerRadius(45.0)
        }
    }
    
    func updateBarWidth() {
        Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
            barWidthPercentage = Float(recorder.audioPlayer.currentTime / recorder.audioPlayer.duration)
        }
    }
}

