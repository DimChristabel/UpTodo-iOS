//
//  LoginView.swift
//  upToDo
//
//  Created by Maxut Consulting on 26/05/2026.
//

import SwiftUI

// MARK: - Login View
struct LoginView: View {
    
    
    var body: some View {
        ZStack {
            // Background
            Color.black.ignoresSafeArea()
            
            // Loading overlay
            if viewModel.isLoading {
                ProgressView()
                    .tint(.white)
                    .scaleEffect(1.5)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // ── Back button ──
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 20,
                                          weight: .medium))
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 36)
                    
                    // ── Title ──
                    Text("Login")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 36)
                    
                    // ── Username field ──
                    AuthTextField(
                        label: "Username",
                        placeholder: "Enter your Username",
                        text: $viewModel.loginUsername
                    )
                    .padding(.bottom, 16)
                    
                    // ── Password field ──
                    AuthTextField(
                        label: "Password",
                        placeholder: "············",
                        text: $viewModel.loginPassword,
                        isSecure: true
                    )
                    .padding(.bottom, 16)
                    
                    // ── Inline error message ──
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .font(.system(size: 13))
                            .foregroundColor(.red)
                            .padding(.bottom, 8)
                    }
                    
                    // ── Login button ──
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Login")
                            .font(.system(size: 16,
                                          weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(red: 0.53,
                                              green: 0.46,
                                              blue: 1.0))
                            .cornerRadius(4)
                    }
                    .padding(.bottom, 24)
                    .disabled(viewModel.isLoading)
                    
                    // ── OR divider ──
                    ORDivider()
                        .padding(.bottom, 24)
                    
                    // ── Google Sign In ──
                    SocialButton(
                        icon: "google_icon",
                        title: "Login with Google"
                    ) {
                        viewModel.signInWithGoogle()
                    }
                    .padding(.bottom, 16)
                    
                    // ── Apple Sign In ──
                    SocialButton(
                        icon: "apple_icon",
                        title: "Login with Apple"
                    ) {
                        // Apple Sign In — coming soon
                    }
                    .padding(.bottom, 36)
                    
                    // ── Register link ──
                    HStack {
                        Spacer()
                        Text("Don't have an account? ")
                            .foregroundColor(.gray)
                            .font(.system(size: 13))
                        NavigationLink("Register") {
                            RegisterView()
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 13,
                                      weight: .bold))
                        Spacer()
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - OR Divider
struct ORDivider: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 1)
            Text("or")
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .padding(.horizontal, 12)
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 1)
        }
    }
}

// MARK: - Social Button
struct SocialButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.white.opacity(0.3),
                            lineWidth: 1)
            )
        }
    }
}

#Preview {
    LoginView()
}


















