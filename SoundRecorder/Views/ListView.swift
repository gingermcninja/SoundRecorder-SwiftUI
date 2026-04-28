//
//  ListView.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import SwiftUI
import AVFoundation

class PlaybackDelegate: NSObject, AVAudioPlayerDelegate {
    var onFinished: (() -> Void)?

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            self.onFinished?()
        }
    }
}

struct ListView: View {
    @EnvironmentObject var audioManager: AudioManager
    @State private var currentlyPlayingURL: URL?
    @State private var renamingURL: URL?
    @State private var renameText: String = ""
    @State private var playbackDelegate = PlaybackDelegate()

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
                                        audioManager.audioPlayer?.stop()
                                        currentlyPlayingURL = nil
                                    } else {
                                        playRecording(url: url)
                                    }
                                }) {
                                    Image(systemName: currentlyPlayingURL == url ? "stop.circle" : "play.circle")
                                        .imageScale(.large)
                                }
                            }
                        }
                        .contentShape(Rectangle())
                        .swipeActions(edge: .leading) {
                            Button {
                                renameText = url.deletingPathExtension().lastPathComponent
                                renamingURL = url
                            } label: {
                                Label("Rename", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                        .onTapGesture {
                            if currentlyPlayingURL == url {
                                audioManager.audioPlayer?.stop()
                                currentlyPlayingURL = nil
                            } else {
                                playRecording(url: url)
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
            .onAppear {
                playbackDelegate.onFinished = {
                    currentlyPlayingURL = nil
                }
            }
            .alert("Rename Recording", isPresented: Binding(
                get: { renamingURL != nil },
                set: { if !$0 { renamingURL = nil } }
            )) {
                TextField("Name", text: $renameText)
                Button("Cancel", role: .cancel) { renamingURL = nil }
                Button("Save") {
                    guard let url = renamingURL, !renameText.isEmpty else { return }
                    if let newURL = audioManager.renameRecording(at: url, to: renameText) {
                        if currentlyPlayingURL == url {
                            currentlyPlayingURL = newURL
                        }
                    }
                    renamingURL = nil
                }
            }
        }
    }
    private func playRecording(url: URL) {
        do {
            audioManager.audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioManager.audioPlayer?.delegate = playbackDelegate
            audioManager.audioPlayer?.prepareToPlay()
            audioManager.audioPlayer?.play()
            currentlyPlayingURL = url
        } catch {
            // Silently fail
        }
    }
}

#Preview {
    ListView()
        .environmentObject(AudioManager())
}
