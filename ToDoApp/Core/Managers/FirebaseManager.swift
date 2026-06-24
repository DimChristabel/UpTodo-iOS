//
//  FirebaseManager.swift
//  upToDo
//
//  Created by Maxut Consulting on 19/06/2026.
//

//
//  FirebaseManager.swift
//  upToDo
//
//  Created by Christabel Dim
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// MARK: - FirebaseManager

/// Centralized access point for Firebase services.
///
/// This manager provides shared references
/// to Authentication and Firestore.
///
/// Example:
///
/// FirebaseManager.shared.auth
/// FirebaseManager.shared.firestore
///
final class FirebaseManager {

    // MARK: Singleton

    static let shared = FirebaseManager()

    // MARK: Firebase Services

    let auth: Auth
    let firestore: Firestore

    // MARK: Initializer

    private init() {

        self.auth = Auth.auth()

        self.firestore = Firestore.firestore()
    }
}
