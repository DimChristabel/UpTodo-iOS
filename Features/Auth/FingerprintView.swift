//
//  FingerprintView.swift
//  upToDo
//
//  Created by Maxut Consulting on 31/05/2026.
//

import SwiftUI

// MARK: - FingerprintView

/// Provides optional biometric authentication
/// using Face ID, Touch ID, or device passcode.
///
/// Returning users can authenticate using
/// biometrics or skip directly into the app.
struct FingerprintView: View {

    // MARK: Properties

    @ObservedObject
    var viewModel: AuthViewModel

    /// Called when biometric authentication
    /// succeeds.
    let onAuthenticationPassed: () -> Void

    /// Called when the user skips
    /// biometric authentication.
    let onCancelDismiss: () -> Void

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack {

                Spacer()

                // MARK: Title

                Text("Biometric Authentication")
                    .font(
                        .system(
                            size: 32,
                            weight: .bold
                        )
                    )
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Spacer()

                // MARK: Biometric Button

                Button {

                    viewModel.verifyFingerprint {

                        onAuthenticationPassed()
                    }

                } label: {

                    Image(systemName: "touchid")
                        .font(.system(size: 120))
                        .foregroundColor(
                            Color("MildPurple")
                        )
                }

                Spacer()

                // MARK: Status Message

                Text(
                    viewModel.fingerprintMessage.isEmpty
                    ? "Use Face ID, Touch ID, or continue without biometrics."
                    : viewModel.fingerprintMessage
                )
                .foregroundColor(
                    viewModel.isFingerprintFailed
                    ? .red
                    : .gray
                )
                .multilineTextAlignment(.center)
                .padding(.horizontal)

                Spacer()

                // MARK: Authentication Options

                HStack {

                    // Skip biometrics

                    Button("Cancel") {

                        onCancelDismiss()
                    }

                    Spacer()

                    // Continue without biometrics

                    Button("Use Password") {

                        onCancelDismiss()
                    }
                }
                .foregroundColor(
                    Color("MildPurple")
                )
                .padding(.horizontal, 40)

                Spacer()
            }
        }
    }
}

// MARK: - Preview

#Preview {

    FingerprintView(
        viewModel: AuthViewModel(),
        onAuthenticationPassed: {},
        onCancelDismiss: {}
    )
    .preferredColorScheme(.dark)
}
