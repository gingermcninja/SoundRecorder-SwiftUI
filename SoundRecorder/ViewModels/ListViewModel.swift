//
//  ListViewModel.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/12/26.
//

import Foundation
import AVFoundation
import Combine

class ListViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var recordingNames: [URL] = AudioManager.shared.recordingNames
    var currentlyPlayingURL: URL? = nil
    var audioPlayer: AVAudioPlayer? = nil
    
    func playAudio(from url: URL) throws {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        audioPlayer?.delegate = self
        currentlyPlayingURL = url
    }

    func stopAudio(from url: URL) {
        if currentlyPlayingURL == url {
            audioPlayer?.stop()
            audioPlayer = nil
            currentlyPlayingURL = nil
        }
    }
    
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
