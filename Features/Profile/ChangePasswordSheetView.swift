//
//  ChangePasswordSheetView.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - ChangePasswordSheetView

/// Allows users to update their account password.
///
/// Users must enter:
/// - Current Password
/// - New Password
/// - Confirm Password
///
/// The new password is validated before
/// being updated in Firebase Authentication.
struct ChangePasswordSheetView: View {

    // MARK: Properties

    @ObservedObject
    var viewModel: ProfileViewModel

    @Environment(\.dismiss)
    private var dismiss

    // MARK: Form Values

    @State private var oldPassword = ""

    @State private var newPassword = ""

    @State private var confirmPassword = ""

    // MARK: UI State

    @State private var errorMessage = ""

    @State private var showError = false

    @State private var isLoading = false

    // MARK: Body

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black
                    .ignoresSafeArea()

                VStack(
                    spacing: 20
                ) {

                    // MARK: Current Password

                    SecureField(
                        "Current Password",
                        text: $oldPassword
                    )
                    .padding()
                    .background(
                        Color.white.opacity(0.08)
                    )
                    .cornerRadius(12)

                    // MARK: New Password

                    SecureField(
                        "New Password",
                        text: $newPassword
                    )
                    .padding()
                    .background(
                        Color.white.opacity(0.08)
                    )
                    .cornerRadius(12)

                    // MARK: Confirm Password

                    SecureField(
                        "Confirm Password",
                        text: $confirmPassword
                    )
                    .padding()
                    .background(
                        Color.white.opacity(0.08)
                    )
                    .cornerRadius(12)

                    if isLoading {

                        ProgressView()
                    }

                    Spacer()
                }
                .padding()
            }

            .navigationTitle("Change Password")
            .navigationBarTitleDisplayMode(.inline)

            // MARK: Toolbar

            .toolbar {

                ToolbarItem(
                    placement: .topBarLeading
                ) {

                    Button("Cancel") {

                        dismiss()
                    }
                }

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Button("Save") {

                        updatePassword()
                    }
                    .disabled(isLoading)
                }
            }

            // MARK: Alert

            .alert(
                "Error",
                isPresented: $showError
            ) {

                Button("OK") { }

            } message: {

                Text(errorMessage)
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: Password Update

    private func updatePassword() {

        guard !newPassword.isEmpty else {

            errorMessage =
            "Password cannot be empty."

            showError = true

            return
        }

        guard newPassword.count >= 6 else {

            errorMessage =
            "Password must be at least 6 characters."

            showError = true

            return
        }

        guard newPassword == confirmPassword else {

            errorMessage =
            "Passwords do not match."

            showError = true

            return
        }

        isLoading = true

        viewModel.changePassword(

            currentPassword: oldPassword,

            newPassword: newPassword

        ) { result in
            isLoading = false

            switch result {

            case .success:

                dismiss()

            case .failure(let error):

                errorMessage =
                error.localizedDescription

                showError = true
            }
        }
    }
}

// MARK: - Preview

#Preview {

    ChangePasswordSheetView(
        viewModel: ProfileViewModel()
    )
    .preferredColorScheme(.dark)
}
