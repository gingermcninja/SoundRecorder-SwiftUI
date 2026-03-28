//
//  AudioManager.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import Foundation
import AVFoundation
import Combine

class AudioManager {
    static let shared = AudioManager()
    var recordingNames: [URL] = []
    private var audioPlayer: AVAudioPlayer? = nil
    private var currentlyPlayingURL: URL? = nil
    
    
}
