//
//  ListView.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import SwiftUI
import AVFoundation

class AudioDelegate: NSObject, AVAudioPlayerDelegate {
    var currentlyPlayingURL: URL? = nil
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.currentlyPlayingURL = nil
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: (any Error)?) {
        self.currentlyPlayingURL = nil
    }
    
    init(currentlyPlayingURL: URL? = nil) {
        self.currentlyPlayingURL = currentlyPlayingURL
    }
}

struct ListItem: View {
    var url: URL
    @State private var audioPlayer: AVAudioPlayer? = nil
    @State private var currentlyPlayingURL: URL? = nil
    @StateObject var listViewModel: ListViewModel
    
    var body: some View {
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
                            let delegate = AudioDelegate(currentlyPlayingURL: currentlyPlayingURL)
                            audioPlayer?.delegate = delegate
                        }
                    } else {
                        do {
                            try listViewModel.playAudio(from: url)
                        } catch {
                            // Silently fail
                        }
                    }
                }) {
                    Image(systemName: (currentlyPlayingURL == url && (audioPlayer?.isPlaying ?? false)) ? "pause.circle" : "play.circle")
                        .imageScale(.large)
                }
                Button(role: .destructive, action: {
                    listViewModel.stopAudio(from: url)
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
                    let delegate = AudioDelegate(currentlyPlayingURL: currentlyPlayingURL)
                    audioPlayer?.delegate = delegate
                }
            } else {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.prepareToPlay()
                    audioPlayer?.play()
                    currentlyPlayingURL = url
                    let delegate = AudioDelegate(currentlyPlayingURL: currentlyPlayingURL)
                    audioPlayer?.delegate = delegate
                } catch {
                    // Silently fail
                }
            }
        }
    }
}

struct ListView: View {
    //@StateObject private var audioManager = AudioManager.shared
    @StateObject private var listViewModel: ListViewModel = ListViewModel()
    //@State private var audioPlayer: AVAudioPlayer?
    //@State private var currentlyPlayingURL: URL?

    var body: some View {
        NavigationStack {
            List {
                if listViewModel.recordingNames.isEmpty {
                    Text("No recordings yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(Array(listViewModel.recordingNames.enumerated()), id: \.element) { index, url in
                        ListItem(url: url, listViewModel: listViewModel)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let url = listViewModel.recordingNames[index]
                            try? FileManager.default.removeItem(at: url)
                        }
                        listViewModel.recordingNames.remove(atOffsets: indexSet)
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
