//
//  RegisterView.swift
//  upToDo
//
//  Created by Maxut Consulting on 31/05/2026.
//

import SwiftUI

// MARK: - RegisterView

/// Provides the user registration interface.
///
/// Allows new users to create an account by
/// entering their details before creating
/// an account.
struct RegisterView: View {

    // MARK: Properties

    @ObservedObject
    var viewModel: AuthViewModel

    /// Called when registration completes successfully.
    let onRegisterSuccess: () -> Void

    /// Called when the user chooses to navigate
    /// to the login screen.
    let onLoginTapped: () -> Void

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

                    // MARK: Screen Title

                    Text("Register")
                        .font(
                            .system(
                                size: 32,
                                weight: .bold
                            )
                        )
                        .foregroundColor(.white)
                        .padding(.bottom, 12)

                    // MARK: Full Name Input

                    AuthTextField(
                        title: "Full Name",
                        placeholder: "Enter your full name",
                        text: $viewModel.fullName
                    )

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

                    // MARK: Confirm Password Input

                    AuthSecureField(
                        title: "Confirm Password",
                        placeholder: "Confirm password",
                        text: $viewModel.confirmPassword
                    )

                    // MARK: Validation Error

                    if !viewModel.errorMessage.isEmpty {

                        Text(viewModel.errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    // MARK: Register Button

                    PrimaryButton(
                        title: viewModel.isLoading
                        ? "Creating Account..."
                        : "Register"
                    ) {

                        guard !viewModel.isLoading else {
                            return
                        }

                        viewModel.register {

                            onRegisterSuccess()
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

                    // MARK: Google Sign In

                    SocialAuthButton(
                        title: "Continue with Google",
                        systemIcon: nil,
                        assetIcon: "google_icon"
                    ) {

                        viewModel.signInWithGoogle {

                            onRegisterSuccess()
                        }
                    }
                    
                    Spacer()
                        .frame(height: 12)

                    // MARK: Login Navigation

                    HStack {

                        Spacer()

                        Text("Already have an account?")
                            .foregroundColor(.gray)

                        Button("Login") {

                            onLoginTapped()
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
            "Registration Error",
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

    RegisterView(
        viewModel: AuthViewModel(),
        onRegisterSuccess: {},
        onLoginTapped: {},
        onBack: {}
    )
    .preferredColorScheme(.dark)
}
