//
//  RecordView.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        Color.black.ignoresSafeArea().overlay {
            VStack {
                Spacer()
                Text("Record screen coming soon!")
                    .foregroundStyle(.white)
                    .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    RecordView()
}
