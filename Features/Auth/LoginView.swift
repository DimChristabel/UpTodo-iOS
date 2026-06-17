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
/// their credentials and access the application.
/// The screen also provides navigation to account
/// registration and alternative social login options.
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

                    // MARK: Username Input

                    AuthTextField(
                        title: "Username",
                        placeholder: "Enter username",
                        text: $viewModel.username
                    )

                    // MARK: Password Input

                    AuthSecureField(
                        title: "Password",
                        placeholder: "Enter password",
                        text: $viewModel.password
                    )

                    // MARK: Login Action

                    PrimaryButton(
                        title: "Login"
                    ) {

                        viewModel.login {

                            onLoginSuccess()
                        }
                    }

                    // MARK: Authentication Divider

                    ORDivider()

                    // MARK: Social Authentication

                    SocialButton(
                        title: "Login with Google",
                        icon: "globe"
                    ) {

                    }

                    SocialButton(
                        title: "Login with Apple",
                        icon: "apple.logo"
                    ) {

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
