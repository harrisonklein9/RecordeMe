//
//  ContentView.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/24/20.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var showFormatSheet = false
    @State private var showEncoderSheet = false
    @State private var playbackProgress: Float = 0.0
    @State private var darkModeEnabled = false
    @State private var recordings: [Recording] = []
    @ObservedObject var audioRecorder: RecorderPlayer = RecorderPlayer()
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(alignment: .center, spacing: 20, content: {
                    
                    ToolbarView(darkModeEnabled: $darkModeEnabled)
                    
                    ProgressView(recorder: audioRecorder, progress: $playbackProgress)
                        .frame(height: 20)
                    
                    RecorderControlView(recorder: audioRecorder, darkModeEnabled: $darkModeEnabled)
                        .padding(.horizontal, 50).shadow(color: .black, radius: 1.0)
                    
                    RecordingsList(recorder: audioRecorder, darkMode: $darkModeEnabled)
                    
                    PickersView(recorder: audioRecorder, showFormatSheet: $showFormatSheet, showEncoderSheet: $showEncoderSheet).padding()
                    
                    Spacer()
                    
                })
                .padding(.top, 50)
                .padding(.horizontal, 20)
            }
        }
        .background(darkModeEnabled ? Color.black : Color.white )
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
