//
//  FocusViewModel.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import Foundation
import Combine
import SwiftUI

// MARK: - FocusSessionType

/// Represents the current focus session mode.
enum FocusSessionType {

    case work

    case breakTime
}

// MARK: - FocusViewModel

/// Manages the application's focus timer functionality.
///
/// Implements a Pomodoro-style workflow by alternating
/// between work sessions and break sessions while
/// tracking progress and timer state.
final class FocusViewModel: ObservableObject {

    // MARK: Published Properties

    @Published var timeRemaining = 25 * 60

    @Published var isRunning = false

    @Published var progress: CGFloat = 1.0

    @Published var sessionType: FocusSessionType = .work

    @Published var showAlert = false

    @Published var alertMessage = ""

    @Published var completedSessions = 0

    // MARK: Private Properties

    private var totalTime = 25 * 60

    private var timer: AnyCancellable?

    // MARK: Timer Controls

    /// Starts the focus timer.
    ///
    /// Prevents multiple timers from running simultaneously.
    func start() {

        guard !isRunning else {
            return
        }

        isRunning = true

        timer = Timer
            .publish(
                every: 1,
                on: .main,
                in: .common
            )
            .autoconnect()
            .sink { [weak self] _ in

                guard let self else {
                    return
                }

                if self.timeRemaining > 0 {

                    self.timeRemaining -= 1

                    self.progress =
                    CGFloat(self.timeRemaining)
                    /
                    CGFloat(self.totalTime)

                } else {

                    self.sessionFinished()
                }
            }
    }

    /// Pauses the currently running timer.
    func pause() {

        timer?.cancel()

        isRunning = false
    }

    /// Resets the timer back to the default
    /// work session duration.
    func reset() {

        pause()

        sessionType = .work

        totalTime = 25 * 60

        timeRemaining = totalTime

        progress = 1

        completedSessions = 0
    }

    // MARK: Session Management

    /// Handles the transition between work
    /// and break sessions when a timer ends.
    private func sessionFinished() {

        pause()

        if sessionType == .work {

            completedSessions += 1

            sessionType = .breakTime

            totalTime = 5 * 60

            timeRemaining = totalTime

            progress = 1

            alertMessage =
            "Work session completed. Break time!"

        } else {

            sessionType = .work

            totalTime = 25 * 60

            timeRemaining = totalTime

            progress = 1

            alertMessage =
            "Break finished. Ready to focus?"
        }

        showAlert = true
    }

    // MARK: Computed Properties

    /// Returns the remaining time formatted
    /// as MM:SS for display in the user interface.
    var timeString: String {

        let minutes = timeRemaining / 60

        let seconds = timeRemaining % 60

        return String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
    }
}
