//
//  StartView.swift
//  upToDo
//
//  Created by Maxut Consulting on 26/05/2026.
//


import SwiftUI

// MARK: - WelcomeView

/// Displays the application's welcome screen.
///
/// This screen serves as the entry point to the
/// authentication flow, allowing users to either
/// sign in to an existing account or create a new
/// account before accessing the application.
struct WelcomeView: View {

    // MARK: Navigation Actions

    /// Called when the user chooses to log in.
    let onLogin: () -> Void

    /// Called when the user chooses to create
    /// a new account.
    let onRegister: () -> Void

    /// Called when the user navigates back to
    /// the previous screen.
    let onBack: () -> Void

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack {

                // MARK: Back Navigation

                HStack {

                    Button(action: onBack) {

                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)

                Spacer()

                // MARK: Welcome Title

                Text("Welcome to UpTodo")
                    .font(
                        .system(
                            size: 32,
                            weight: .bold
                        )
                    )
                    .foregroundColor(.white)

                Spacer()
                    .frame(height: 20)

                // MARK: Welcome Description

                Text(
                    "Please login to your account or create a new account to continue"
                )
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

                Spacer()

                // MARK: Authentication Actions

                VStack(spacing: 20) {

                    PrimaryButton(
                        title: "LOGIN"
                    ) {

                        onLogin()
                    }

                    OutlineButton(
                        title: "CREATE ACCOUNT"
                    ) {

                        onRegister()
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
    }
}

// MARK: - Preview

#Preview {

    WelcomeView(
        onLogin: {},
        onRegister: {},
        onBack: {}
    )
    .preferredColorScheme(.dark)
}
