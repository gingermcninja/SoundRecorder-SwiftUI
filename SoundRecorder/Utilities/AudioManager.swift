//
//  AudioManager.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    var recordingNames: [URL] = []
}
