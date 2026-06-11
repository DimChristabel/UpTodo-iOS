//
//  RegisterView.swift
//  upToDo
//
//  Created by Maxut Consulting on 31/05/2026.
//

import SwiftUI

// MARK: - RegisterView
struct RegisterView: View {

    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // Back Button
                    IconButton(
                        iconName: "chevron.left",
                        iconSize: 20,
                        iconWeight: .regular,
                        frameSize: 24
                    ) {
                        dismiss()
                    }
                    .padding(.top, 57)

                    // Title
                    Text("Register")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 32)
                        .padding(.bottom, 32)

                    // Username
                    FieldLabel(
                        title: "Username",
                        fontSize: 16,
                        fontWeight: .regular
                    )

                    InputField(
                        placeholder: "Enter your Username",
                        text: $username
                    )
                    .padding(.bottom, 20)

                    // Password
                    FieldLabel(
                        title: "Password",
                        fontSize: 16,
                        fontWeight: .regular
                    )

                    SecureInputField(
                        placeholder: "••••••••••••",
                        text: $password
                    )
                    .padding(.bottom, 20)

                    // Confirm Password
                    FieldLabel(
                        title: "Confirm Password",
                        fontSize: 16,
                        fontWeight: .regular
                    )

                    SecureInputField(
                        placeholder: "••••••••••••",
                        text: $confirmPassword
                    )
                    .padding(.bottom, 24)

                    // Register Button
                    PrimaryButton(
                        title: "Register"
                    ) {
                        // Register action
                    }
                    .padding(.bottom, 24)

                    // OR Divider
                    ORDivider()
                        .padding(.bottom, 24)

                    // Google Register
                    SocialAuthButton(
                        title: "Register with Google",
                        assetIcon: "google_icon"
                    ) {
                        // Google Register Action
                    }
                    .padding(.bottom, 16)

                    // Apple Register
                    SocialAuthButton(
                        title: "Register with Apple",
                        systemIcon: "apple.logo"
                    ) {
                        // Apple Register Action
                    }

                    // Login Link
                    HStack(spacing: 0) {
                        Spacer()

                        Text("Already have an account? ")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))

                        Button {
                            dismiss()
                        } label: {
                            Text("Login")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .bold))
                        }

                        Spacer()
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        RegisterView()
    }
}
