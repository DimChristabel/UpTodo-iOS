//
//  AppUser.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//
import Foundation
import FirebaseFirestore

// MARK: - AppUser

/// Represents an authenticated user
/// stored in Firestore.
struct AppUser: Identifiable, Codable {

    // MARK: Properties

    let id: String

    var displayName: String

    var email: String

    var avatarURL: String

    var createdAt: Date
}
