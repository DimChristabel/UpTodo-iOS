//
//  FirestoreService.swift
//  upToDo
//
//  Created by Maxut Consulting on 19/06/2026.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

// MARK: - FirestoreService

/// Handles all Firestore database operations
/// related to application users.
final class FirestoreService {
    
    // MARK: Singleton
    
    static let shared = FirestoreService()
    
    private init() {}
    
    // MARK: Properties
    
    private let db = Firestore.firestore()
    
    // MARK: Listener

    private var taskListener: ListenerRegistration?
    
    // MARK: Create User

    /// Creates a user document only if
    /// one does not already exist.
    ///
    /// Path:
    /// users/{uid}
    func createUser(
        user: AppUser,
        completion: @escaping (
            Result<Void, Error>
        ) -> Void
    ) {

        let documentRef = db
            .collection("users")
            .document(user.id)

        documentRef.getDocument {

            snapshot,
            error in

            if let error {

                completion(
                    .failure(error)
                )

                return
            }

            // MARK: User Already Exists

            if snapshot?.exists == true {

                completion(
                    .success(())
                )

                return
            }

            // MARK: Create New User

            do {

                try documentRef
                    .setData(
                        from: user
                    ) { error in

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

            } catch {

                completion(
                    .failure(error)
                )
            }
        }
    }
    
    // MARK: Task Operations
    
    /// Creates a task document in Firestore.
    func createTask(
        task: AppTask,
        completion: @escaping (
            Result<Void, Error>
        ) -> Void
    ) {
        
        do {
            
            try db
                .collection("users")
                .document(task.userId)
                .collection("tasks")
                .document(task.id)
                .setData(
                    from: task
                ) { error in
                    
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
            
        } catch {
            
            completion(
                .failure(error)
            )
        }
    }
    
    
    // MARK: Listen For Tasks

    func listenForTasks(
        userId: String,
        completion: @escaping (
            Result<[AppTask], Error>
        ) -> Void
    ) {

        taskListener?.remove()

        taskListener = db
            .collection("users")
            .document(userId)
            .collection("tasks")
            .addSnapshotListener { snapshot, error in

                if let error {

                    completion(
                        .failure(error)
                    )

                    return
                }

                guard let documents =
                        snapshot?.documents
                else {

                    completion(
                        .success([])
                    )

                    return
                }

                let tasks = documents.compactMap {

                    try? $0.data(
                        as: AppTask.self
                    )
                }

                completion(
                    .success(tasks)
                )
            }
    }
    
    // MARK: Stop Listening

    func stopListening() {

        taskListener?.remove()
        taskListener = nil
    }
    
    
    // MARK: - Update Task

    func updateTask(
        task: AppTask,
        completion: @escaping (
            Result<Void, Error>
        ) -> Void
    ) {

        do {

            try db
                .collection("users")
                .document(task.userId)
                .collection("tasks")
                .document(task.id)
                .setData(
                    from: task
                ) { error in

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

        } catch {

            completion(
                .failure(error)
            )
        }
    }
    
    
    // MARK: Toggle Task Completion

    /// Updates a task's completion status
    /// inside Firestore.
    func toggleTaskCompletion(
        task: AppTask,
        completion: @escaping (
            Result<Void, Error>
        ) -> Void
    ) {

        db.collection("users")
            .document(task.userId)
            .collection("tasks")
            .document(task.id)
            .updateData([

                "isCompleted": !task.isCompleted

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
    
    
    
    // MARK: Delete Task

    /// Deletes a task document from Firestore.
    func deleteTask(
        task: AppTask,
        completion: @escaping (
            Result<Void, Error>
        ) -> Void
    ) {

        db.collection("users")
            .document(task.userId)
            .collection("tasks")
            .document(task.id)
            .delete { error in

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
