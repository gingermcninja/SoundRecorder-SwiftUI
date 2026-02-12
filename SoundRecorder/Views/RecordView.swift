//
//  RecordView.swift
//  SoundRecorder
//
//  Created by Paul McGrath on 2/11/26.
//

import SwiftUI
import AVFoundation
import Combine

struct RecordView: View {
    @StateObject private var vm = AudioRecorderViewModel()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 24) {
                Text("Record")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)

                if vm.authorizationStatus == .denied {
                    Text("Microphone access denied. Please enable it in Settings.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                } else {
                    Text(formatTime(vm.elapsedTime))
                        .font(.system(size: 48, weight: .medium, design: .monospaced))
                        .foregroundColor(.white)
                }

                if vm.authorizationStatus == .authorized {
                    if vm.isRecording {
                        Button {
                            vm.stopRecording()
                        } label: {
                            ZStack {
                                Circle()
                                    .stroke(Color.red, lineWidth: 5)
                                    .frame(width: 140, height: 140)
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 56, height: 56)
                            }
                        }
                        .accessibilityLabel("Stop recording")
                        .buttonStyle(PlainButtonStyle())

                        Button {
                            vm.stopRecording(save: false)
                        } label: {
                            Text("Discard")
                                .foregroundColor(.red.opacity(0.8))
                                .padding(.top, 12)
                        }
                        .buttonStyle(PlainButtonStyle())

                    } else {
                        Button {
                            vm.startRecording()
                        } label: {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 140, height: 140)
                                .overlay(
                                    Text("Record")
                                        .foregroundColor(.white)
                                        .font(.title2.bold())
                                )
                        }
                        .accessibilityLabel("Start recording")
                        .buttonStyle(PlainButtonStyle())
                    }
                } else if vm.authorizationStatus == .notDetermined {
                    Button {
                        vm.requestPermission()
                    } label: {
                        Text("Allow Microphone")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }

                if let error = vm.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.top, 8)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top, 60)
            .padding(.horizontal)
        }
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let totalSeconds = Int(time)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    RecordView()
}
