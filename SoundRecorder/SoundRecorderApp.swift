//
//  SoundRecorderApp.swift
//  SoundRecorder2
//
//  Created by Paul McGrath on 12/3/25.
//

import SwiftUI
import AVFoundation

@main
struct SoundRecorderApp: App {
    @StateObject private var audioManager = AudioManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
