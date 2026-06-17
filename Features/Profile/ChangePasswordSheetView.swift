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
/// Users must provide their current password,
/// enter a new password, and confirm the new
/// password before submitting the change.
///
/// Note:
/// Password validation and Firebase Authentication
/// integration will be implemented in a future update.
struct ChangePasswordSheetView: View {

    // MARK: Properties

    @ObservedObject
    var viewModel: TaskViewModel

    @State private var oldPassword = ""

    @State private var newPassword = ""

    @State private var confirmPassword = ""

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                // MARK: Sheet Title

                Text("Change Password")
                    .font(.headline)
                    .foregroundColor(.white)

                // MARK: Password Inputs

                SecureField(
                    "Current Password",
                    text: $oldPassword
                )
                .padding()
                .background(
                    Color.white.opacity(0.08)
                )
                .cornerRadius(8)

                SecureField(
                    "New Password",
                    text: $newPassword
                )
                .padding()
                .background(
                    Color.white.opacity(0.08)
                )
                .cornerRadius(8)

                SecureField(
                    "Confirm Password",
                    text: $confirmPassword
                )
                .padding()
                .background(
                    Color.white.opacity(0.08)
                )
                .cornerRadius(8)

                // MARK: Sheet Actions

                HStack {

                    Button("Cancel") {

                        viewModel.showChangePasswordSheet = false
                    }

                    Spacer()

                    Button("Update") {

                        viewModel.showChangePasswordSheet = false
                    }
                }
                .foregroundColor(
                    Color("MildPurple")
                )
            }
            .padding()
            .frame(width: 320)
            .background(Color.black)
            .cornerRadius(12)
        }
    }
}

// MARK: - Preview

#Preview {

    ChangePasswordSheetView(
        viewModel: TaskViewModel()
    )
    .preferredColorScheme(.dark)
}
