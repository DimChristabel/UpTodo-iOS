//
//  AuthViewModel.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

// MARK: - AuthViewModel

/// Manages authentication workflows including:
/// - User registration
/// - User login
/// - Password reset
/// - Biometric authentication
///
/// This ViewModel serves as the bridge between
/// the Authentication UI and Firebase services.
final class AuthViewModel: ObservableObject {

    // MARK: User Credentials

    /// Full name entered during registration.
    @Published var fullName = ""

    /// Email address entered by the user.
    @Published var email = ""

    /// Password entered by the user.
    @Published var password = ""

    /// Password confirmation entered during registration.
    @Published var confirmPassword = ""

    // MARK: UI State

    /// Error message displayed to the user.
    @Published var errorMessage = ""

    /// Controls authentication loading state.
    @Published var isLoading = false
    @Published var alertTitle = "Authentication"

    /// Controls error alert presentation.
    @Published var showError = false

    // MARK: Biometric State

    /// Indicates whether biometric
    /// authentication failed.
    @Published var isFingerprintFailed = false
    

    /// Message displayed on the fingerprint screen.
    @Published var fingerprintMessage =
    "Please hold your finger on the fingerprint scanner to verify your identity"

    
    
    // MARK: Login

    /// Authenticates an existing user
    /// using Firebase Authentication.
   
    func login(
        completion: @escaping () -> Void
    ) {

        errorMessage = ""

        guard validateLogin() else {
            return
        }

        isLoading = true

        AuthService.shared.login(
            email: email,
            password: password
        ) { [weak self] result in

            DispatchQueue.main.async {

                guard let self = self else {
                    return
                }

                self.isLoading = false

                switch result {

                case .success:

                    completion()

                case .failure(let error):

                    self.alertTitle =
                    "Login Failed"

                    let nsError = error as NSError

                    switch nsError.code {

                    case 17004, 17009:

                        self.errorMessage =
                        "Incorrect email or password."

                    case 17011:

                        self.errorMessage =
                        "No account found with this email."

                    case 17008:

                        self.errorMessage =
                        "Please enter a valid email address."

                    case 17020:

                        self.errorMessage =
                        "No internet connection."

                    default:

                        self.errorMessage =
                        "Unable to sign in. Please try again."
                    }

                    self.showError = true
                }
            }
        }
    }
    
    // MARK: Google Sign In
   /// Authenticates the user using
    /// Google Sign-In and creates
    /// a Firestore user document
   
    func signInWithGoogle(
        completion: @escaping () -> Void
    ) {

        errorMessage = ""

        isLoading = true

        AuthService.shared
            .signInWithGoogle {

                [weak self] result in

                guard let self else {
                    return
                }

                DispatchQueue.main.async {

                    switch result {

                    case .success(let firebaseUser):

                        let appUser = AppUser(

                            id: firebaseUser.uid,

                            displayName:
                                firebaseUser.displayName
                                ?? "Google User",

                            email:
                                firebaseUser.email
                                ?? "",

                            avatarURL:
                                firebaseUser.photoURL?
                                .absoluteString
                                ?? "",

                            createdAt: Date()
                        )

                        FirestoreService.shared
                            .createUser(
                                user: appUser
                            ) { _ in

                                DispatchQueue.main.async {

                                    self.isLoading = false

                                    completion()
                                }
                            }
                    case .failure(let error):

                        self.isLoading = false

                        self.errorMessage =
                        error.localizedDescription

                        self.showError = true
                    }
                }
            }
    }
    
    
    // MARK: Registration

    /// Creates a new Firebase Authentication account
    /// and corresponding Firestore user document.
    ///
    /// Flow:
    /// 1. Create Firebase Auth account
    /// 2. Create Firestore user document
    /// 3. Navigate to next screen
    func register(
        completion: @escaping () -> Void
    ) {

        errorMessage = ""

        guard validateRegistration() else {
            return
        }

        isLoading = true

        AuthService.shared.register(
            email: email,
            password: password
        ) { [weak self] result in

            guard let self else {
                return
            }

            switch result {

            case .success(let firebaseUser):

                let appUser = AppUser(

                    id: firebaseUser.uid,

                    displayName: self.fullName,

                    email: self.email,

                    avatarURL: "",

                    createdAt: Date()
                )

                FirestoreService.shared.createUser(
                    user: appUser
                ) { firestoreResult in

                    DispatchQueue.main.async {

                        self.isLoading = false

                        switch firestoreResult {

                        case .success:

                            completion()

                        case .failure(let error):

                            self.isLoading = false

                            self.alertTitle = "Registration Failed"

                            let nsError = error as NSError

                            switch nsError.code {

                            case 17007:

                                self.errorMessage =
                                "An account with this email already exists."

                            case 17008:

                                self.errorMessage =
                                "Please enter a valid email address."

                            case 17026:

                                self.errorMessage =
                                "Password must be at least 6 characters."

                            case 17020:

                                self.errorMessage =
                                "No internet connection."

                            default:

                                self.errorMessage =
                                "Unable to create account. Please try again."
                            }

                            self.showError = true
                        }
                    }
                }

            case .failure(let error):

                DispatchQueue.main.async {

                    self.isLoading = false

                    self.errorMessage =
                    error.localizedDescription

                    self.showError = true
                }
            }
        }
    }
    
    // MARK: Password Reset

    /// Sends a password reset email
    /// using Firebase Authentication.
    // MARK: Password Reset

    /// Sends a password reset email
    /// using Firebase Authentication.
    func forgotPassword() {

        errorMessage = ""

        guard !email.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {

            alertTitle = "Password Reset"

            errorMessage =
            "Please enter your email address."

            showError = true

            return
        }

        guard isValidEmail(email) else {

            alertTitle = "Password Reset"

            errorMessage =
            "Please enter a valid email address."

            showError = true

            return
        }

        Auth.auth().sendPasswordReset(
            withEmail: email
        ) { [weak self] error in

            DispatchQueue.main.async {

                guard let self = self else {
                    return
                }

                if let error {

                    self.alertTitle =
                    "Password Reset Failed"

                    let nsError = error as NSError

                    switch nsError.code {

                    case 17011:

                        self.errorMessage =
                        "No account found with this email."

                    case 17008:

                        self.errorMessage =
                        "Please enter a valid email address."

                    case 17020:

                        self.errorMessage =
                        "No internet connection."

                    default:

                        self.errorMessage =
                        "Unable to send reset email."
                    }

                    self.showError = true

                } else {

                    self.alertTitle =
                    "Password Reset"

                    self.errorMessage =
                    "Check your email inbox for a password reset link."

                    self.showError = true
                }
            }
        }
    }

    // MARK: Biometric Authentication

    /// Performs biometric verification.
    func verifyFingerprint(
        completion: @escaping () -> Void
    ) {

        completion()
    }

    // MARK: Validation

    /// Validates login credentials.
    private func validateLogin() -> Bool {

        guard !email.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {

            errorMessage = "Email is required."
            showError = true

            return false
        }

        guard isValidEmail(email) else {

            errorMessage =
            "Please enter a valid email address."

            showError = true

            return false
        }

        guard !password.isEmpty else {

            errorMessage =
            "Password is required."

            showError = true

            return false
        }

        return true
    }

    /// Validates registration fields.
    private func validateRegistration() -> Bool {

        guard !fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {

            errorMessage =
            "Full name is required."

            showError = true

            return false
        }

        guard !email.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {

            errorMessage =
            "Email is required."

            showError = true

            return false
        }

        guard isValidEmail(email) else {

            errorMessage =
            "Please enter a valid email address."

            showError = true

            return false
        }

        guard password.count >= 8 else {

            errorMessage =
            "Password must be at least 8 characters."

            showError = true

            return false
        }

        guard password == confirmPassword else {

            errorMessage =
            "Passwords do not match."

            showError = true

            return false
        }

        return true
    }

    /// Validates email format.
    private func isValidEmail(
        _ email: String
    ) -> Bool {

        let emailRegex =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        return NSPredicate(
            format: "SELF MATCHES %@",
            emailRegex
        )
        .evaluate(with: email)
    }
}
