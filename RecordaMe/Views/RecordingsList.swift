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
                        
                        VStack{
                            Text(recording.title)
                                .bold()
                                .font(.system(size: 24))
                                .foregroundColor(darkMode ? .white : .black)
                                .frame(width: geo.size.width, alignment: .topLeading)
                                .onTapGesture {
                                    recorder.playRecording(recording.location)
                                }
                            Text(recording.dateCreated.shortDate())
                                .foregroundColor(darkMode ? .white : .black)
                                .frame(width: geo.size.width, alignment: .topLeading)
                        }.background(darkMode ? Color.black : Color.white)
                        
                        Spacer(minLength: 10)
                        
                        Rectangle()
                            .frame(width: geo.size.width, height: 0.5, alignment: .center)
                            .foregroundColor(.gray)
                    }
                }.frame(width: geo.size.width)
            }
        }
    }
}


extension Date {
    func shortDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: self)
    }
}
