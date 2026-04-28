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

    func renameRecording(at url: URL, to newName: String) -> URL? {
        let newURL = url.deletingLastPathComponent()
            .appendingPathComponent(newName)
            .appendingPathExtension(url.pathExtension)

        do {
            try FileManager.default.moveItem(at: url, to: newURL)
        } catch {
            return nil
        }

        if let index = recordingNames.firstIndex(of: url) {
            recordingNames[index] = newURL
        }

        for (buttonIndex, assignedURL) in buttonAssignments where assignedURL == url {
            buttonAssignments[buttonIndex] = newURL
        }

        return newURL
    }
}
