//
//  ContentView.swift
//  Fart2
//
//  Created by Paul McGrath on 12/3/25.
//

import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer?

struct ContentView: View {
    //let parent = Fart2App()
    var body: some View {
        Color.black.ignoresSafeArea().overlay {
            VStack {
                HStack(spacing: 50) {
                    Button("Button1", action: {
                        self.btnPressed(buttonIndex: 1)
                    })
                    .padding()
                    .background(Color.red.ignoresSafeArea(.all))
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    
                    Button("Button2", action: {
                        self.btnPressed(buttonIndex: 2)
                    }).padding()
                        .background(Color.red.ignoresSafeArea(.all))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())

                }
                .padding()
                HStack(spacing: 50) {
                    Button("Button3", action: {
                        self.btnPressed(buttonIndex: 3)
                    }).padding()
                        .background(Color.red.ignoresSafeArea(.all))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())

                    Button("Button4", action: {
                        self.btnPressed(buttonIndex: 4)
                    }).padding()
                        .background(Color.red.ignoresSafeArea(.all))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())

                }
                .padding()
                HStack(spacing: 50) {
                    Button("Button5", action: {
                        self.btnPressed(buttonIndex: 5)
                    }).padding()
                        .background(Color.red.ignoresSafeArea(.all))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())

                    Button("Button6", action: {
                        self.btnPressed(buttonIndex: 6)
                    }).padding()
                        .background(Color.red.ignoresSafeArea(.all))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())

                }
                .padding()
            }
            .padding()
        }
    }
    
    
    func btnPressed(buttonIndex: Int) {
        var filename: String = "nutz"
        if buttonIndex != 1 {
            filename = "fart-0\(buttonIndex)"
        }
        guard let url = Bundle.main.url(forResource: filename, withExtension: "wav") else {
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = audioPlayer else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
