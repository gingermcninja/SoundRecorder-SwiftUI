//
//  Recording.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 5/8/26.
//

import Foundation

struct Recording: Identifiable, Equatable, Hashable {
    let id: UUID
    var name: String
    var url: URL
    
    init(name: String, recordingURL: URL) {
        self.id = UUID()
        self.name = name
        self.url = recordingURL
    }
}
