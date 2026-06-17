//
//  AppUser.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//
import Foundation

// MARK: - App User Model
/// Represents a registered application user.
struct AppUser: Identifiable, Codable {

    /// Firestore document id.
    let id: String

    /// User display name.
    var displayName: String

    /// User email address.
    var email: String

    /// Profile image url.
    var avatarURL: String

    /// Account creation date.
    var createdAt: Date
}

