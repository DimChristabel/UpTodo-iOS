//
//  LoginView.swift
//  upToDo
//
//  Created by Maxut Consulting on 31/05/2026.
//

import SwiftUI

struct LoginView: View {

    @State private var username = ""
    @State private var password = ""

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
                    Text("Login")
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
                    .padding(.bottom, 24)

                    // Login Button
                    PrimaryButton(
                        title: "Login"
                    ) {
                        // Login action
                    }
                    .padding(.bottom, 24)

                    // OR Divider
                    ORDivider()
                        .padding(.bottom, 24)

                    // Google Login
                    SocialAuthButton(
                        title: "Login with Google",
                        assetIcon: "google_icon"
                    ) {
                        // Google Sign In
                    }
                    .padding(.bottom, 16)

                    // Apple Login
                    SocialAuthButton(
                        title: "Login with Apple",
                        systemIcon: "apple.logo"
                    ) {
                        // Apple Sign In
                    }

                    // Register Link
                    HStack(spacing: 0) {
                        Spacer()

                        Text("Don't have an account? ")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))

                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Register")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
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

#Preview {
    NavigationStack {
        LoginView()
    }
}
