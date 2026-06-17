//
//  AppRootView.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - AppRootView

/// Root navigation container for the application.
///
/// Responsible for managing the app's navigation flow,
/// including onboarding, authentication, biometric
/// verification, and the main dashboard experience.
struct AppRootView: View {

    // MARK: Properties

    @State private var currentState: AppNavigationState = .intro

    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var taskViewModel = TaskViewModel()

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            switch currentState {

            // MARK: Intro Flow

            case .intro:

                IntroView()
                    .transition(.opacity)
                    .onAppear {

                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 2
                        ) {

                            withAnimation(.easeInOut) {

                                currentState = .onboarding
                            }
                        }
                    }

            // MARK: Onboarding Flow

            case .onboarding:

                OnboardingView {

                    withAnimation(.easeInOut) {

                        currentState = .welcome
                    }
                }
                .transition(.move(edge: .trailing))

            // MARK: Welcome Flow

            case .welcome:

                WelcomeView(

                    onLogin: {

                        withAnimation(.easeInOut) {

                            currentState = .login
                        }
                    },

                    onRegister: {

                        withAnimation(.easeInOut) {

                            currentState = .register
                        }
                    },

                    onBack: {

                        withAnimation(.easeInOut) {

                            currentState = .onboarding
                        }
                    }
                )
                .transition(.move(edge: .leading))

            // MARK: Login Flow

            case .login:

                LoginView(

                    viewModel: authViewModel,

                    onLoginSuccess: {

                        withAnimation(.easeInOut) {

                            currentState = .fingerprint
                        }
                    },

                    onRegisterTapped: {

                        withAnimation(.easeInOut) {

                            currentState = .register
                        }
                    },

                    onBack: {

                        withAnimation(.easeInOut) {

                            currentState = .welcome
                        }
                    }
                )
                .transition(.move(edge: .trailing))

            // MARK: Registration Flow

            case .register:

                RegisterView(

                    viewModel: authViewModel,

                    onRegisterSuccess: {

                        withAnimation(.easeInOut) {

                            currentState = .fingerprint
                        }
                    },

                    onLoginTapped: {

                        withAnimation(.easeInOut) {

                            currentState = .login
                        }
                    },

                    onBack: {

                        withAnimation(.easeInOut) {

                            currentState = .welcome
                        }
                    }
                )
                .transition(.move(edge: .trailing))

            // MARK: Biometric Authentication Flow

            case .fingerprint:

                FingerprintView(

                    viewModel: authViewModel,

                    onAuthenticationPassed: {

                        withAnimation(.easeInOut) {

                            currentState = .dashboard
                        }
                    },

                    onCancelDismiss: {

                        withAnimation(.easeInOut) {

                            currentState = .welcome
                        }
                    }
                )

            // MARK: Main Application Flow

            case .dashboard:

                MainTabView(
                    viewModel: taskViewModel
                )
            }
        }

        // MARK: Logout Observer

        .onChange(
            of: taskViewModel.isLoggedOut
        ) { _, newValue in

            guard newValue else {
                return
            }

            currentState = .welcome
            taskViewModel.isLoggedOut = false
        }
    }
}

// MARK: - Preview

#Preview {

    AppRootView()
}
