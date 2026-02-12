//
//  AudioManager.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import Foundation
import AVFoundation
import Combine

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    @Published var recordingNames: [URL] = []
}

class AVDelegate: NSObject, AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: (any Error)?) {
        
    }
}
