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
    var body: some View {
        TabView {
            BoardView()
            .tabItem { Label("Playback", systemImage: "play.circle") }
            ListView()
            .tabItem { Label("List", systemImage: "list.bullet.circle") }
            RecordView()
            .tabItem { Label("Record", systemImage: "mic.circle") }
        }
    }
    
    
    
}

#Preview {
    ContentView()
}
