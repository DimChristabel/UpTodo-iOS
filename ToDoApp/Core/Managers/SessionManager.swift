//
//  SessionManager.swift
//  upToDo
//
//  Created by Maxut Consulting on 19/06/2026.
//

import Foundation
import FirebaseAuth
import Combine

// MARK: - SessionManager

/// Manages authentication session state
/// throughout the application.
final class SessionManager: ObservableObject {

    @Published var isLoggedIn = false

    init() {

        isLoggedIn =
        Auth.auth().currentUser != nil
    }

    func refreshSession() {

        isLoggedIn =
        Auth.auth().currentUser != nil
    }
}
