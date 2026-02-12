//
//  BoardView.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import SwiftUI
import AVFoundation

struct PlaybackButton: View {
    var buttonText: String
    var buttonIndex: Int
    var boardViewModel: BoardViewModel
    var body: some View {
        Button(buttonText, action: {
            boardViewModel.btnPressed(buttonIndex: buttonIndex)
        })
        .padding()
        .background(Color.red.ignoresSafeArea(.all))
        .foregroundStyle(.white)
        .clipShape(Capsule())
    }
}

struct BoardView: View {
    let boardViewModel = BoardViewModel()
    var body: some View {
        Color.black.ignoresSafeArea().overlay {
            VStack {
                HStack(spacing: 50) {
                    PlaybackButton(buttonText: "Button1", buttonIndex: 1, boardViewModel: boardViewModel)
                    PlaybackButton(buttonText: "Button2", buttonIndex: 2, boardViewModel: boardViewModel)
                }
                .padding()
                HStack(spacing: 50) {
                    PlaybackButton(buttonText: "Button3", buttonIndex: 3, boardViewModel: boardViewModel)
                    PlaybackButton(buttonText: "Button4", buttonIndex: 4, boardViewModel: boardViewModel)
                }
                .padding()
                HStack(spacing: 50) {
                    PlaybackButton(buttonText: "Button5", buttonIndex: 5, boardViewModel: boardViewModel)
                    PlaybackButton(buttonText: "Button6", buttonIndex: 6, boardViewModel: boardViewModel)
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    BoardView()
}
