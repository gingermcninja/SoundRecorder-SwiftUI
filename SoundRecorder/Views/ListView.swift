//
//  ListView.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        Color.black.ignoresSafeArea().overlay {
            VStack {
                Spacer()
                Text("List screen coming soon!")
                    .foregroundStyle(.white)
                    .padding()
                Spacer()
            }
        }

    }
}

#Preview {
    ListView()
}
