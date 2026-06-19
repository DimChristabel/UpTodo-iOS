//
//  FirestoreService.swift
//  upToDo
//
//  Created by Maxut Consulting on 19/06/2026.
//

import Foundation
import FirebaseFirestore


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
    
    /// Creates a user document in Firestore
    /// immediately after Firebase Authentication
    /// registration succeeds.
    ///
    /// Path:
    /// users/{uid}
    func createUser(
        user: AppUser,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        
        do {
            
            try db
                .collection("users")
                .document(user.id)
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
