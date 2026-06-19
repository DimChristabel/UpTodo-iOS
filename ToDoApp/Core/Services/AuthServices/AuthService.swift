//
//  AuthService.swift
//  upToDo
//
//  Created by Maxut Consulting on 19/06/2026.
//

import Foundation
import FirebaseAuth

// MARK: - AuthService

/// Handles all Firebase Authentication
/// operations throughout the application.
final class AuthService {

    // MARK: Singleton

    static let shared = AuthService()

    private init() {}

    // MARK: Current User

    /// Returns the currently authenticated user.
    var currentUser: User? {

        Auth.auth().currentUser
    }

    // MARK: Registration

    /// Creates a new Firebase user account.
    ///
    /// - Parameters:
    ///   - email: User email address.
    ///   - password: User password.
    ///   - completion: Completion handler.
    func register(
        email: String,
        password: String,
        completion: @escaping (
            Result<User, Error>
        ) -> Void
    ) {

        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { result, error in

            if let error {

                completion(.failure(error))
                return
            }

            guard let user = result?.user else {
                return
            }

            completion(.success(user))
        }
    }

    // MARK: Login

    /// Authenticates an existing user.
    ///
    /// - Parameters:
    ///   - email: User email address.
    ///   - password: User password.
    ///   - completion: Completion handler.
    func login(
        email: String,
        password: String,
        completion: @escaping (
            Result<User, Error>
        ) -> Void
    ) {

        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { result, error in

            if let error {

                completion(.failure(error))
                return
            }

            guard let user = result?.user else {
                return
            }

            completion(.success(user))
        }
    }

    // MARK: Logout

    /// Signs out the current user.
    func logout() throws {

        try Auth.auth().signOut()
    }
}
