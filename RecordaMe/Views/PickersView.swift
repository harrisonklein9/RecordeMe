//
//  PickersView.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/25/20.
//

import SwiftUI

struct PickersView: View {
    
    @ObservedObject var recorder: RecorderPlayer
    @Binding var showFormatSheet: Bool
    @Binding var showEncoderSheet: Bool
    
    
    var body: some View {
        HStack {
            
            ZStack {
                Rectangle()
                    .cornerRadius(5)
                    .frame(width: 130, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1.5, x: 0, y: 0)
                
                FormatPicker(recorder: recorder, showActionSheet: $showFormatSheet)
            }
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .cornerRadius(5)
                    .frame(width: 130, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1.5, x: 0, y: 0)
                
                QualityPicker(recorder: recorder, showActionSheet: $showEncoderSheet)
            }
            
        }
    }
}
