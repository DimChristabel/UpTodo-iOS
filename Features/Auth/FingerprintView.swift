//
//  FingerprintView.swift
//  upToDo
//
//  Created by Maxut Consulting on 31/05/2026.
//

import SwiftUI

// MARK: - FingerprintView

/// Provides biometric authentication using
/// Touch ID or device-supported fingerprint
/// verification.
///
/// Users can authenticate using biometrics
/// before accessing the main application or
/// choose to return to the previous screen.
struct FingerprintView: View {

    // MARK: Properties

    @ObservedObject
    var viewModel: AuthViewModel

    /// Called when biometric authentication
    /// completes successfully.
    let onAuthenticationPassed: () -> Void

    /// Called when the user cancels the
    /// authentication process.
    let onCancelDismiss: () -> Void

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack {

                Spacer()

                // MARK: Screen Title

                Text("Fingerprint")
                    .font(
                        .system(
                            size: 32,
                            weight: .bold
                        )
                    )
                    .foregroundColor(.white)

                Spacer()

                // MARK: Biometric Authentication

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

                // MARK: Authentication Status

                Text(
                    viewModel.fingerprintMessage
                )
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

                // MARK: Authentication Options

                HStack {

                    Button("Cancel") {

                        onCancelDismiss()
                    }

                    Spacer()

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
