//
//  StorageService.swift
//  upToDo
//
//  Created by Maxut Consulting on 19/06/2026.
//
import Foundation
import FirebaseStorage

// MARK: - StorageService

/// Handles Firebase Storage operations,
/// including profile image uploads.
final class StorageService {

    // MARK: Singleton

    static let shared = StorageService()

    private init() {}

    // MARK: Properties

    private let storage =
    Storage.storage()

    // MARK: Avatar Reference

    /// Returns a storage reference
    /// for a user's profile image.
    func avatarReference(
        userId: String
    ) -> StorageReference {

        storage.reference()
            .child("avatars")
            .child("\(userId).jpg")
    }
}
