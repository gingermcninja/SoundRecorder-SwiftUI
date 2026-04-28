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
        let url: URL
        let fileTypeHint: String?

        if let assignedURL = audioManager.buttonAssignments[buttonIndex] {
            url = assignedURL
            fileTypeHint = nil
        } else if let bundleURL = Bundle.main.url(forResource: "fart-0\(buttonIndex)", withExtension: "wav") {
            url = bundleURL
            fileTypeHint = AVFileType.wav.rawValue
        } else {
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioManager.audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: fileTypeHint)
            audioManager.audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }

}
