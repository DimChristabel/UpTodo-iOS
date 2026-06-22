//
//  LoginView.swift
//  upToDo
//
//  Created by Maxut Consulting on 31/05/2026.
//
import SwiftUI

// MARK: - LoginView

/// Provides the user login interface.
///
/// Allows existing users to authenticate using
/// Firebase Authentication and access the
/// application dashboard.
///
/// The screen also provides:
/// - Password reset
/// - Biometric Authentication
/// - Google Sign-In
/// - Apple Sign-In
/// - Navigation to registration
struct LoginView: View {

    // MARK: Properties

    @ObservedObject
    var viewModel: AuthViewModel

    let onLoginSuccess: () -> Void
    let onFingerprintTapped: () -> Void
    let onRegisterTapped: () -> Void
    let onBack: () -> Void

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            ScrollView {

                VStack(
                    alignment: .leading,
                    spacing: 28
                ) {

                    // MARK: Back Button

                    HStack {

                        Button {

                            onBack()

                        } label: {

                            Image(systemName: "chevron.left")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                        }

                        Spacer()
                    }
                    .padding(.bottom, 30)

                    // MARK: Title

                    Text("Login")
                        .font(
                            .system(
                                size: 32,
                                weight: .bold
                            )
                        )
                        .foregroundColor(.white)
                        .padding(.bottom, 12)

                    // MARK: Email

                    AuthTextField(
                        title: "Email",
                        placeholder: "Enter your email",
                        text: $viewModel.email
                    )

                    // MARK: Password

                    AuthSecureField(
                        title: "Password",
                        placeholder: "Enter password",
                        text: $viewModel.password
                    )

                    // MARK: Forgot Password

                    HStack {

                        Spacer()

                        Button("Forgot Password?") {

                            viewModel.forgotPassword()
                        }
                        .foregroundColor(
                            Color("MildPurple")
                        )
                        .font(.footnote)
                    }

                    // MARK: Validation Error

                    if !viewModel.errorMessage.isEmpty {

                        Text(viewModel.errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    // MARK: Login Button

                    PrimaryButton(
                        title: viewModel.isLoading
                        ? "Signing In..."
                        : "Login"
                    ) {

                        guard !viewModel.isLoading else {
                            return
                        }

                        viewModel.login {

                            onLoginSuccess()
                        }
                    }
                    .disabled(viewModel.isLoading)

                    // MARK: Loading Indicator

                    if viewModel.isLoading {

                        HStack {

                            Spacer()

                            ProgressView()
                                .tint(.white)

                            Spacer()
                        }
                    }

                    // MARK: Divider

                    ORDivider()

                    // MARK: Fingerprint Authentication

                    Button {

                        onFingerprintTapped()

                    }label: {

                        HStack(spacing: 12) {

                            Image(systemName: "touchid")
                                .font(.title3)

                            Text("Use Biometrics")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            Color.black.opacity(0.15)
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 8
                            )
                            .stroke(
                                Color.gray.opacity(0.4),
                                lineWidth: 1
                            )
                        )
                    }

                    // MARK: Google Sign In

                    SocialAuthButton(
                        title: "Continue with Google",
                        systemIcon: nil,
                        assetIcon: "google_icon"
                    ) {

                        viewModel.signInWithGoogle {

                            onLoginSuccess()
                        }
                    }

                    // MARK: Apple Sign In

                    SocialAuthButton(
                        title: "Continue with Apple",
                        systemIcon: nil,
                        assetIcon: "apple_icon"
                    ) {

                        // Apple Sign-In
                    }

                    Spacer()
                        .frame(height: 12)

                    // MARK: Register

                    HStack {

                        Spacer()

                        Text("Don't have an account?")
                            .foregroundColor(.gray)

                        Button("Register") {

                            onRegisterTapped()
                        }
                        .foregroundColor(.white)

                        Spacer()
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 60)
                .padding(.bottom, 24)
            }
        }

        // MARK: Alert

        .alert(
            viewModel.alertTitle,
            isPresented: $viewModel.showError
        ) {

            Button("OK") {

                viewModel.showError = false
            }

        } message: {

            Text(viewModel.errorMessage)
        }
    }
}

// MARK: - Preview

#Preview {

    LoginView(
        viewModel: AuthViewModel(),
        onLoginSuccess: {},
        onFingerprintTapped: {},
        onRegisterTapped: {},
        onBack: {}
    )
    .preferredColorScheme(.dark)
}
