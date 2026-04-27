//
//  BoardViewModel.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import Foundation
import AVFoundation

class BoardViewModel {
    private let audioManager: AudioManager

    init(audioManager: AudioManager) {
        self.audioManager = audioManager
    }

    func btnPressed(buttonIndex: Int) {
        guard let url = Bundle.main.url(forResource: "fart-0\(buttonIndex)", withExtension: "wav") else {
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioManager.audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = audioManager.audioPlayer else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

}
