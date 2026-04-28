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
    @Published var recordingNames: [URL] = []
    @Published var buttonAssignments: [Int: URL] = [:]
    var audioPlayer: AVAudioPlayer?
}
