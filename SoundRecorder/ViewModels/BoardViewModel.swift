//
//  BoardViewModel.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import Foundation
import AVFoundation

class BoardViewModel {
    
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
