//
//  FocusView.swift
//  upToDo
//
//  Created by Maxut Consulting on 09/06/2026.
//

import SwiftUI

// MARK: - FocusView

/// Provides a Pomodoro-style focus timer experience.
///
/// Users can start, pause, and reset focus sessions
/// while tracking progress through a circular timer.
struct FocusView: View {

    // MARK: Properties

    @StateObject
    private var viewModel = FocusViewModel()

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack {

                // MARK: Screen Title

                Text("Focus Mode")
                    .font(.title2)
                    .foregroundColor(.white)

                // MARK: Session Type

                Text(
                    viewModel.sessionType == .work
                    ? "Focus Session"
                    : "Break Session"
                )
                .font(.headline)
                .foregroundColor(
                    Color("MildPurple")
                )
                .padding(.top, 8)

                Spacer()

                // MARK: Timer Display

                ZStack {

                    Circle()
                        .stroke(
                            Color.gray.opacity(0.3),
                            lineWidth: 12
                        )

                    Circle()
                        .trim(
                            from: 0,
                            to: viewModel.progress
                        )
                        .stroke(
                            Color("MildPurple"),
                            style: StrokeStyle(
                                lineWidth: 12,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(
                            .degrees(-90)
                        )

                    Text(
                        viewModel.timeString
                    )
                    .font(.largeTitle)
                    .foregroundColor(.white)
                }
                .frame(
                    width: 250,
                    height: 250
                )

                // MARK: Session Counter

                Text(
                    "Completed Sessions: \(viewModel.completedSessions)"
                )
                .foregroundColor(.gray)
                .padding(.top, 20)

                Spacer()

                // MARK: Timer Controls

                HStack(spacing: 20) {

                    Button {

                        if viewModel.isRunning {

                            viewModel.pause()

                        } else {

                            viewModel.start()
                        }

                    } label: {

                        Text(
                            viewModel.isRunning
                            ? "Pause"
                            : "Start"
                        )
                    }

                    Button {

                        viewModel.reset()

                    } label: {

                        Text("Reset")
                    }
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
        }

        // MARK: Session Alert

        .alert(
            "Session Complete",
            isPresented: $viewModel.showAlert
        ) {

            Button("OK") { }

        } message: {

            Text(
                viewModel.alertMessage
            )
        }
    }
}

// MARK: - Preview

#Preview {

    FocusView()
        .preferredColorScheme(.dark)
}
