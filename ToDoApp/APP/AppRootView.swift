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
/// Controls:
/// - Intro
/// - Onboarding
/// - Authentication
/// - Biometric Verification
/// - Dashboard
///
/// Restores Firebase authentication sessions
/// and automatically reloads Firestore user
/// data and tasks.
struct AppRootView: View {

    // MARK: Navigation State

    @State private var currentState: AppNavigationState = .intro

    // MARK: View Models

    @StateObject private var authViewModel = AuthViewModel()

    @StateObject private var taskViewModel = TaskViewModel()

    // MARK: Session Manager

    @StateObject private var sessionManager = SessionManager()

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            switch currentState {

            // MARK: Intro

            case .intro:

                IntroView()
                    .transition(.opacity)
                    .onAppear {

                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 2
                        ) {

                            withAnimation(.easeInOut) {

                                if sessionManager.isLoggedIn {

                                    // Load User Profile
                                    taskViewModel.loadCurrentUser()

                                    // Load Firestore Tasks
                                    taskViewModel.loadTasks()

                                    currentState = .dashboard

                                } else {

                                    currentState = .onboarding
                                }
                            }
                        }
                    }

            // MARK: Onboarding

            case .onboarding:

                OnboardingView {

                    withAnimation(.easeInOut) {

                        currentState = .welcome
                    }
                }
                .transition(
                    .move(edge: .trailing)
                )

            // MARK: Welcome

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
                .transition(
                    .move(edge: .leading)
                )

            // MARK: Login

            case .login:

                LoginView(

                    viewModel: authViewModel,

                    onLoginSuccess: {

                        sessionManager.refreshSession()

                        taskViewModel.loadCurrentUser()
                        taskViewModel.loadTasks()

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
                .transition(
                    .move(edge: .trailing)
                )

            // MARK: Register

            case .register:

                RegisterView(

                    viewModel: authViewModel,

                    onRegisterSuccess: {

                        sessionManager.refreshSession()

                        taskViewModel.loadCurrentUser()
                        taskViewModel.loadTasks()

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
                .transition(
                    .move(edge: .trailing)
                )

            // MARK: Fingerprint

            case .fingerprint:

                FingerprintView(

                    viewModel: authViewModel,

                    onAuthenticationPassed: {

                        taskViewModel.loadCurrentUser()
                        taskViewModel.loadTasks()

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

            // MARK: Dashboard

            case .dashboard:

                MainTabView(
                    viewModel: taskViewModel
                )
                .onAppear {

                    guard sessionManager.isLoggedIn
                    else {
                        return
                    }

                    taskViewModel.loadCurrentUser()
                    taskViewModel.loadTasks()
                }
            }
        }

        // MARK: Logout Observer

        .onChange(
            of: taskViewModel.isLoggedOut
        ) { _, newValue in

            guard newValue else {
                return
            }

            sessionManager.refreshSession()

            // Clear cached data

            taskViewModel.tasks.removeAll()
            taskViewModel.currentUser = nil

            authViewModel.email = ""
            authViewModel.password = ""
            authViewModel.confirmPassword = ""

            currentState = .welcome

            taskViewModel.isLoggedOut = false
        }
    }
}

// MARK: - Preview

#Preview {

    AppRootView()
}
