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
/// - Google Sign-In
/// - Apple Sign-In
/// - Navigation to registration
struct LoginView: View {

    // MARK: Properties

    @ObservedObject
    var viewModel: AuthViewModel

    /// Called when login completes successfully.
    let onLoginSuccess: () -> Void

    /// Called when the user chooses to navigate
    /// to the registration screen.
    let onRegisterTapped: () -> Void

    /// Called when the user returns to the
    /// previous screen.
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

                    // MARK: Back Navigation

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

                    // MARK: Screen Title

                    Text("Login")
                        .font(
                            .system(
                                size: 32,
                                weight: .bold
                            )
                        )
                        .foregroundColor(.white)
                        .padding(.bottom, 12)

                    // MARK: Email Input

                    AuthTextField(
                        title: "Email",
                        placeholder: "Enter your email",
                        text: $viewModel.email
                    )

                    // MARK: Password Input

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

                    // MARK: Authentication Divider

                    ORDivider()

                    // MARK: Google Authentication

                    SocialAuthButton(
                        title: "Continue with Google",
                        systemIcon: nil,
                        assetIcon: "google_icon"
                    ) {

                        // Google Sign-In
                        // will be connected later.
                    }

                    // MARK: Apple Authentication

                    SocialAuthButton(
                        title: "Continue with Apple",
                        systemIcon: nil,
                        assetIcon: "apple_icon"
                    ) {

                        // Apple Sign-In
                        // will be connected later.
                    }

                    Spacer()
                        .frame(height: 12)

                    // MARK: Registration Navigation

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

        // MARK: Error Alert

        .alert(
            "Authentication Error",
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
        onRegisterTapped: {},
        onBack: {}
    )
    .preferredColorScheme(.dark)
}
