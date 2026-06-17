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
/// entering a username, password, and password
/// confirmation before proceeding to biometric
/// authentication.
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

                    // MARK: Confirm Password Input

                    AuthSecureField(
                        title: "Confirm Password",
                        placeholder: "Confirm password",
                        text: $viewModel.confirmPassword
                    )

                    // MARK: Register Button

                    PrimaryButton(
                        title: "Register"
                    ) {

                        viewModel.register {

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
