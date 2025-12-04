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
        HStack {
            Button("Button1", action: {
                self.btnPressed(buttonIndex: 1)
            }).padding()
            Button("Button2", action: {
                self.btnPressed(buttonIndex: 2)
            }).padding()
        }
        .padding()
        HStack {
            Button("Button3", action: {
                self.btnPressed(buttonIndex: 3)
            }).padding()
            Button("Button4", action: {
                self.btnPressed(buttonIndex: 4)
            }).padding()
        }
        .padding()
        HStack {
            Button("Button5", action: {
                self.btnPressed(buttonIndex: 5)
            }).padding()
            Button("Button6", action: {
                self.btnPressed(buttonIndex: 6)
            }).padding()
        }
        .padding()
    }
    
    
    func btnPressed(buttonIndex: Int) {
        guard let url = Bundle.main.url(forResource: "fart-0\(buttonIndex)", withExtension: "wav") else {
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
