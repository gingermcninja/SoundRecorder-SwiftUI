//
//  BoardView.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import SwiftUI
import AVFoundation

extension Int: @retroactive Identifiable {
    public var id: Int { self }
}

struct PlaybackButton: View {
    var buttonText: String
    var buttonIndex: Int
    var boardViewModel: BoardViewModel
    var onLongPress: () -> Void

    var body: some View {
        Text(buttonText)
            .padding()
            .background(Color.red.ignoresSafeArea(.all))
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .onTapGesture {
                boardViewModel.btnPressed(buttonIndex: buttonIndex)
            }
            .onLongPressGesture {
                onLongPress()
            }
    }
}

struct RecordingPickerView: View {
    @EnvironmentObject var audioManager: AudioManager
    let buttonIndex: Int
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                if audioManager.recordingNames.isEmpty {
                    Text("No recordings available")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(audioManager.recordingNames, id: \.self) { url in
                        Button {
                            audioManager.buttonAssignments[buttonIndex] = url
                            dismiss()
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(url.deletingPathExtension().lastPathComponent)
                                        .font(.body)
                                    Text(url.lastPathComponent)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                if audioManager.buttonAssignments[buttonIndex] == url {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                }

                if audioManager.buttonAssignments[buttonIndex] != nil {
                    Button("Reset to Default", role: .destructive) {
                        audioManager.buttonAssignments[buttonIndex] = nil
                        dismiss()
                    }
                }
            }
            .navigationTitle("Assign to Button \(buttonIndex)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

struct BoardView: View {
    @EnvironmentObject var audioManager: AudioManager
    @State private var selectedButtonIndex: Int?
    var boardViewModel: BoardViewModel { BoardViewModel(audioManager: audioManager) }

    var body: some View {
        Color.black.ignoresSafeArea().overlay {
            VStack {
                HStack(spacing: 50) {
                    PlaybackButton(buttonText: buttonLabel(1), buttonIndex: 1, boardViewModel: boardViewModel) { selectedButtonIndex = 1 }
                    PlaybackButton(buttonText: buttonLabel(2), buttonIndex: 2, boardViewModel: boardViewModel) { selectedButtonIndex = 2 }
                }
                .padding()
                HStack(spacing: 50) {
                    PlaybackButton(buttonText: buttonLabel(3), buttonIndex: 3, boardViewModel: boardViewModel) { selectedButtonIndex = 3 }
                    PlaybackButton(buttonText: buttonLabel(4), buttonIndex: 4, boardViewModel: boardViewModel) { selectedButtonIndex = 4 }
                }
                .padding()
                HStack(spacing: 50) {
                    PlaybackButton(buttonText: buttonLabel(5), buttonIndex: 5, boardViewModel: boardViewModel) { selectedButtonIndex = 5 }
                    PlaybackButton(buttonText: buttonLabel(6), buttonIndex: 6, boardViewModel: boardViewModel) { selectedButtonIndex = 6 }
                }
                .padding()
            }
            .padding()
        }
        .sheet(item: $selectedButtonIndex) { index in
            RecordingPickerView(buttonIndex: index)
                .environmentObject(audioManager)
        }
    }

    private func buttonLabel(_ index: Int) -> String {
        if let url = audioManager.buttonAssignments[index] {
            return url.deletingPathExtension().lastPathComponent
        }
        return "Button\(index)"
    }
}

#Preview {
    BoardView()
        .environmentObject(AudioManager())
}
