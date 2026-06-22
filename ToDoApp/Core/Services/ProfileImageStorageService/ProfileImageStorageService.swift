//
//  ProfileImageStorageService.swift
//  upToDo
//
//  Created by Maxut Consulting on 21/06/2026.
//

import Foundation
import FirebaseStorage
import FirebaseAuth

// MARK: - ProfileImageStorageService

/// Handles profile image uploads
/// to Firebase Storage.
final class ProfileImageStorageService {

    // MARK: Singleton

    static let shared =
    ProfileImageStorageService()

    private init() { }

    // MARK: Properties

    private let storage =
    Storage.storage()

    // MARK: Upload Profile Image

    /// Uploads a profile image to Firebase Storage
    /// and returns the download URL.
    func uploadProfileImage(

        imageData: Data,

        completion: @escaping (
            Result<String, Error>
        ) -> Void
    ) {

        guard let uid =
                Auth.auth().currentUser?.uid
        else {
            return
        }

        let reference =
        storage.reference()
            .child("profileImages")
            .child("\(uid).jpg")

        reference.putData(
            imageData,
            metadata: nil
        ) { _, error in

            if let error {

                completion(
                    .failure(error)
                )

                return
            }

            reference.downloadURL {

                url,
                error in

                if let error {

                    completion(
                        .failure(error)
                    )

                    return
                }

                guard let url else {
                    return
                }

                completion(
                    .success(
                        url.absoluteString
                    )
                )
            }
        }
    }
}
