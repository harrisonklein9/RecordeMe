//
//  RecordingsList.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/25/20.
//

import SwiftUI

struct RecordingsList: View {
    
    @ObservedObject var recorder: RecorderPlayer
    
    @Binding var darkMode: Bool
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVStack {
                    ForEach(recorder.recordings) { recording in
                        Text(recording.title)
                            .foregroundColor(darkMode ? .white : .black)
                            .frame(width: geo.size.width - 40)
                            .padding()
                            .border(darkMode ? Color.white : Color.black, width: 1)
                            .onTapGesture {
                                recorder.playRecording(recording.location)
                            }
                    }
                }
            }
        }
    }
}
