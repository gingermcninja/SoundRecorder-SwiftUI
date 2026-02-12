//
//  ListView.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import SwiftUI
import AVFoundation

struct ListView: View {
    @StateObject private var audioManager = AudioManager.shared
    @State private var audioPlayer: AVAudioPlayer?
    @State private var currentlyPlayingURL: URL?

    var body: some View {
        NavigationStack {
            List {
                if audioManager.recordingNames.isEmpty {
                    Text("No recordings yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(Array(audioManager.recordingNames.enumerated()), id: \.element) { index, url in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(url.lastPathComponent)
                                    .font(.body)
                                Text(url.deletingPathExtension().lastPathComponent)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            HStack(spacing: 12) {
                                if currentlyPlayingURL == url {
                                    // Now Playing indicator
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 8, height: 8)
                                }
                                Button(action: {
                                    if currentlyPlayingURL == url {
                                        if let player = audioPlayer, player.isPlaying {
                                            player.pause()
                                        } else {
                                            audioPlayer?.play()
                                        }
                                    } else {
                                        do {
                                            audioPlayer = try AVAudioPlayer(contentsOf: url)
                                            audioPlayer?.prepareToPlay()
                                            audioPlayer?.play()
                                            currentlyPlayingURL = url
                                        } catch {
                                            // Silently fail
                                        }
                                    }
                                }) {
                                    Image(systemName: (currentlyPlayingURL == url && (audioPlayer?.isPlaying ?? false)) ? "pause.circle" : "play.circle")
                                        .imageScale(.large)
                                }
                                Button(role: .destructive, action: {
                                    if currentlyPlayingURL == url {
                                        audioPlayer?.stop()
                                        audioPlayer = nil
                                        currentlyPlayingURL = nil
                                    }
                                }) {
                                    Image(systemName: "stop.circle")
                                        .imageScale(.large)
                                }
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if currentlyPlayingURL == url {
                                if let player = audioPlayer, player.isPlaying {
                                    player.pause()
                                } else {
                                    audioPlayer?.play()
                                }
                            } else {
                                do {
                                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                                    audioPlayer?.prepareToPlay()
                                    audioPlayer?.play()
                                    currentlyPlayingURL = url
                                } catch {
                                    // Silently fail
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let url = audioManager.recordingNames[index]
                            try? FileManager.default.removeItem(at: url)
                        }
                        audioManager.recordingNames.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationTitle("Recordings")
        }
    }
}

#Preview {
    ListView()
}
