//
//  TimeView.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/25/20.
//

import SwiftUI

struct TimeView: View {
    
    @ObservedObject var recorder: RecorderPlayer
    @Binding var darkModeEnabled: Bool
    
    var body: some View {
        Text("0:00")
            .font(.system(.headline, design: .rounded))
            .bold()
            .foregroundColor(darkModeEnabled ? .white : .black)
    }
}


