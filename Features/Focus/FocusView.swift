//
//  FocusView.swift
//  upToDo
//
//  Created by Maxut Consulting on 09/06/2026.
//

import SwiftUI
import Combine

// MARK: - Focus Session Type
// Tracks whether we are in work or break mode
enum FocusSessionType {
    case work  // 25 minutes
    case rest  // 5 minutes
}

// MARK: - FocusViewModel
// All timer logic lives here — NOT in the View
// Uses Combine Timer publisher as required by BRD
class FocusViewModel: ObservableObject {
    
    /// Current time remaining in seconds
    @Published var timeRemaining = 25 * 60
    
    /// Whether timer is currently running
    @Published var isRunning = false
    
    /// Current session type — work or break
    @Published var sessionType: FocusSessionType = .work
    
    /// Progress value 0.0 to 1.0 for ring
    @Published var progress: CGFloat = 1.0
    
    /// Whether to show session complete alert
    @Published var showAlert = false
    
    /// Alert message shown to user
    @Published var alertMessage = ""
    
    // ── Total seconds for current session ──
    private var totalSeconds = 25 * 60
    
    // ── Combine timer publisher ──
    private var cancellable: AnyCancellable?
    
    /// Start the timer
    func start() {
        isRunning = true
        cancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.progress = CGFloat(self.timeRemaining)
                        / CGFloat(self.totalSeconds)
                } else {
                    self.sessionEnded()
                }
            }
    }
    
    /// Pause the timer
    func pause() {
        isRunning = false
        cancellable?.cancel()
    }
    
    /// Reset timer back to start
    func reset() {
        pause()
        sessionType   = .work
        totalSeconds  = 25 * 60
        timeRemaining = 25 * 60
        progress      = 1.0
    }
    
    /// Called when session countdown reaches zero
    private func sessionEnded() {
        pause()
        switch sessionType {
        case .work:
            // Switch to break
            sessionType   = .rest
            totalSeconds  = 5 * 60
            timeRemaining = 5 * 60
            progress      = 1.0
            alertMessage  = "Work session done! Starting 5 minute break."
            showAlert     = true
        case .rest:
            // Break done — reset to work
            sessionType   = .work
            totalSeconds  = 25 * 60
            timeRemaining = 25 * 60
            progress      = 1.0
            alertMessage  = "Break over! Ready for next session?"
            showAlert     = true
        }
    }
    
    /// Formatted time string MM:SS
    var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d",
                      minutes, seconds)
    }
}

// MARK: - FocusView
struct FocusView: View {
    
    @StateObject private var viewModel = FocusViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // ── Title ──
                Text("Focus")
                    .font(.system(size: 18,
                                  weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.bottom, 8)
                
                // ── Session type label ──
                Text(viewModel.sessionType == .work
                     ? "Work Session"
                     : "Break Time")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.bottom, 60)
                
                // ── Circular Progress Ring ──
                ZStack {
                    // Background ring
                    Circle()
                        .stroke(
                            Color.white.opacity(0.1),
                            lineWidth: 12)
                        .frame(width: 220, height: 220)
                    
                    // Progress ring — depletes as time passes
                    Circle()
                        .trim(from: 0,
                              to: viewModel.progress)
                        .stroke(
                            Color(red: 0.53,
                                  green: 0.46,
                                  blue: 1.0),
                            style: StrokeStyle(
                                lineWidth: 12,
                                lineCap: .round))
                        .frame(width: 220, height: 220)
                        // Rotate so progress starts at top
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1),
                                   value: viewModel.progress)
                    
                    // Time text inside ring
                    VStack(spacing: 8) {
                        Text(viewModel.timeString)
                            .font(.system(size: 48,
                                          weight: .bold,
                                          design: .monospaced))
                            .foregroundColor(.white)
                        Text(viewModel.sessionType == .work
                             ? "Focus Time"
                             : "Break Time")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.bottom, 60)
                
                // ── Control Buttons ──
                HStack(spacing: 24) {
                    
                    // ── Reset Button ──
                    Button {
                        viewModel.reset()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 20,
                                          weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 52, height: 52)
                            .background(
                                Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                    
                    // ── Start / Pause Button ──
                    Button {
                        viewModel.isRunning
                        ? viewModel.pause()
                        : viewModel.start()
                    } label: {
                        Image(systemName: viewModel.isRunning
                              ? "pause.fill"
                              : "play.fill")
                            .font(.system(size: 24,
                                          weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(
                                Color(red: 0.53,
                                      green: 0.46,
                                      blue: 1.0))
                            .clipShape(Circle())
                    }
                    
                    // ── Skip to next session ──
                    Button {
                        viewModel.reset()
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(.system(size: 20,
                                          weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 52, height: 52)
                            .background(
                                Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
        }
        // ── Session complete alert ──
        .alert("Session Complete",
               isPresented: $viewModel.showAlert) {
            Button("OK") {
                viewModel.start()
            }
        } message: {
            Text(viewModel.alertMessage)
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Preview
#Preview {
    FocusView()
}



