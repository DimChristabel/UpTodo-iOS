//
//  UserFirestoreService.swift
//  upToDo
//
//  Created by Maxut Consulting on 19/06/2026.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

// MARK: - UserFirestoreService

/// Handles all Firestore operations
/// related to application users.
final class UserFirestoreService {
    
    // MARK: Singleton
    
    static let shared = UserFirestoreService()
    
    private init() {}
    
    // MARK: Properties
    
    private let db = Firestore.firestore()
    
    // MARK: Fetch Current User
    
    /// Retrieves the currently authenticated
    /// user's Firestore document.
    ///
    /// Firestore Path:
    /// users/{uid}
    ///
    /// - Parameter completion:
    /// Returns the user document if found.
    func fetchCurrentUser(
        completion: @escaping (
            Result<AppUser, Error>
        ) -> Void
    ) {
        
        guard let uid =
                Auth.auth().currentUser?.uid
        else {
            return
        }
        
        db.collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                
                if let error {
                    
                    print(
                        "Firestore Error:",
                        error.localizedDescription
                    )
                    
                    completion(
                        .failure(error)
                    )
                    
                    return
                }
                
                guard let data =
                        snapshot?.data()
                else {
                    return
                }
                
                let user = AppUser(
                    
                    id:
                        data["id"] as? String
                    ?? uid,
                    
                    displayName:
                        data["displayName"] as? String
                    ?? "User",
                    
                    email:
                        data["email"] as? String
                    ?? "",
                    
                    avatarURL:
                        data["avatarURL"] as? String
                    ?? "",
                    
                    createdAt:
                        (
                            data["createdAt"]
                            as? Timestamp
                        )?.dateValue()
                    ?? Date()
                )
                
                completion(
                    .success(user)
                )
            }
    }
    
    // MARK: Update Display Name
    
    /// Updates the authenticated user's
    /// display name inside Firestore.
    ///
    /// Firestore Path:
    /// users/{uid}
    ///
    /// - Parameters:
    ///   - userId: Firebase Authentication uid.
    ///   - newName: Updated display name.
    ///   - completion: Completion handler.
    func updateDisplayName(
        
        userId: String,
        
        newName: String,
        
        completion: @escaping (
            Result<Void, Error>
        ) -> Void
    ) {
        
        db.collection("users")
            .document(userId)
            .updateData([
                
                "displayName": newName
                
            ]) { error in
                
                if let error {
                    
                    completion(
                        .failure(error)
                    )
                    
                } else {
                    
                    completion(
                        .success(())
                    )
                }
            }
    }
    
    // MARK: - Update Avatar URL

    /// Updates the user's profile image URL
    /// inside Firestore.
    func updateAvatarURL(

        userId: String,

        avatarURL: String,

        completion: @escaping (
            Result<Void, Error>
        ) -> Void
    ) {

        db.collection("users")
            .document(userId)
            .updateData([

                "avatarURL": avatarURL

            ]) { error in

                if let error {

                    completion(
                        .failure(error)
                    )

                } else {

                    completion(
                        .success(())
                    )
                }
            }
    }
    
    
}
