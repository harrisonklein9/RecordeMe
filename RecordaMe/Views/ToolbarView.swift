//
//  ToolbarView.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/24/20.
//

import SwiftUI

struct ToolbarView: View {
    @Binding var darkModeEnabled: Bool
    
    var body: some View {
        HStack {
            Text("RecordaMe")
                .font(.system(.title, design: .rounded))
                .bold()
                .foregroundColor(darkModeEnabled ? .white : .black)
            
            Spacer()
            
            Button(action: {
                self.darkModeEnabled.toggle()
            }) {
                Image(darkModeEnabled ? "sun" : "moon")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(darkModeEnabled ? .white : .black)
                    .frame(width: 50, height: 50, alignment: .center)
            }
        }
    }
}

