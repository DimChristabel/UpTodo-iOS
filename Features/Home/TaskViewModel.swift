//
//  TaskViewModel.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

// MARK: Selected Date Tasks


import Foundation
import SwiftUI
import UIKit
import Combine
import FirebaseAuth
import FirebaseFirestore

// MARK: - TaskViewModel

/// Central ViewModel responsible for managing
/// task data, calendar interactions, user profile
/// information, search functionality, and local
/// data persistence.
///
/// This ViewModel serves as the primary source
/// of truth for the application's task management
/// features and follows the MVVM architecture pattern.

final class TaskViewModel: ObservableObject {
    
    // MARK: User Profile
    
    @Published var userName = "Dim Christabel"
    
    // MARK: Search & Filtering
    
    @Published var searchText = ""
    
    // MARK: Task Collection
    
    @Published var tasks: [AppTask] = []
    
    // MARK: Profile Image
    
    @Published var profileImageData: Data?
    
    // MARK: Calendar State
    
    @Published var selectedDate = Date()
    
    @Published var currentUser: AppUser?
    
    // MARK: UI States
    
    @Published var showAddTaskSheet = false
    @Published var showChangeNameSheet = false
    @Published var showChangePasswordSheet = false
    @Published var todayOnlyFilter = true
    @Published var isLoggedOut = false
    
    // MARK: Storage Keys
    
    
    private let profileImageKey = "profile_image"
    
    // MARK: Firestore
    
    private let firestoreService =
    FirestoreService.shared
    
    // MARK: Initialization
    
    init() {

        loadProfileImage()

        if Auth.auth().currentUser != nil {

            loadCurrentUser()

            loadTasks()
        }
    }
    
    // MARK: Task Statistics
    
    /// Total number of completed tasks.
    
    var completedTasksCount: Int {
        tasks.filter { $0.isCompleted }.count
    }
    
    /// Total number of incomplete tasks.
    var incompleteTasksCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    /// Number of high-priority active tasks.
    var highPriorityTasksCount: Int {
        
        tasks.filter {
            $0.priority >= 8 &&
            !$0.isCompleted
        }
        .count
    }
    
    // MARK: Task Filtering
    /// Returns tasks scheduled for today.
    var todayTasks: [AppTask] {
        
        let calendar = Calendar.current
        
        return tasks.filter {
            calendar.isDateInToday($0.dueDate)
        }
    }
    
    // MARK: Selected Date Tasks
    /// Returns tasks assigned to the
    /// currently selected calendar date.
    var tasksForSelectedDate: [AppTask] {
        
        let calendar = Calendar.current
        
        return tasks
            .filter {
                
                calendar.isDate(
                    $0.dueDate,
                    inSameDayAs: selectedDate
                )
            }
            .sorted {
                
                if $0.priority == $1.priority {
                    
                    return $0.dueDate < $1.dueDate
                }
                
                return $0.priority > $1.priority
            }
    }
    
    // MARK: Calendar Display
    /// Formatted month and year title
    /// displayed within the calendar screen.
    var currentMonthTitle: String {
        
        selectedDate.formatted(
            .dateTime
                .month(.wide)
                .year()
        )
    }
    
    // MARK: Week Dates
    /// Generates all dates belonging
    /// to the currently selected week.
    var currentWeekDates: [Date] {
        
        let calendar = Calendar.current
        
        guard let interval =
                calendar.dateInterval(
                    of: .weekOfYear,
                    for: selectedDate
                )
        else {
            return []
        }
        
        return (0..<7).compactMap {
            
            calendar.date(
                byAdding: .day,
                value: $0,
                to: interval.start
            )
        }
    }
    
    // MARK: Calendar Navigation
    /// Moves calendar selection
    /// to the previous week.
    func moveToPreviousWeek() {
        
        guard let newDate =
                Calendar.current.date(
                    byAdding: .weekOfYear,
                    value: -1,
                    to: selectedDate
                )
        else {
            return
        }
        
        selectedDate = newDate
    }
    
    /// Moves calendar selection
    /// to the next week.
    func moveToNextWeek() {
        
        guard let newDate =
                Calendar.current.date(
                    byAdding: .weekOfYear,
                    value: 1,
                    to: selectedDate
                )
        else {
            return
        }
        
        selectedDate = newDate
    }
    
    /// Moves calendar selection
    /// to the previous month.
    func moveToPreviousMonth() {
        
        guard let newDate =
                Calendar.current.date(
                    byAdding: .month,
                    value: -1,
                    to: selectedDate
                )
        else {
            return
        }
        
        selectedDate = newDate
    }
    
    /// Moves calendar selection
    /// to the next month.
    func moveToNextMonth() {
        
        guard let newDate =
                Calendar.current.date(
                    byAdding: .month,
                    value: 1,
                    to: selectedDate
                )
        else {
            return
        }
        
        selectedDate = newDate
    }
    
    // MARK: Filtered Tasks
    /// Returns tasks filtered using
    /// current search text and date filters.
    var filteredTasks: [AppTask] {
        
        let sourceTasks =
        todayOnlyFilter
        ? todayTasks
        : tasks
        
        guard !searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {
            
            return sourceTasks
        }
        
        return sourceTasks.filter {
            
            $0.title.localizedCaseInsensitiveContains(searchText)
            ||
            $0.description.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    // MARK: Active Tasks
    /// Returns all incomplete tasks.
    var activeTasks: [AppTask] {
        
        filteredTasks.filter {
            !$0.isCompleted
        }
    }
    
    // MARK: Completed Tasks
    /// Returns all completed tasks.
    var completedTasks: [AppTask] {
        
        filteredTasks.filter {
            $0.isCompleted
        }
    }
    
    // MARK: Sorted Tasks
    /// Returns tasks sorted by
    /// completion status, priority,
    /// and due date.
    var sortedTasks: [AppTask] {
        
        filteredTasks.sorted {
            
            if $0.isCompleted != $1.isCompleted {
                
                return !$0.isCompleted
            }
            
            if $0.priority == $1.priority {
                
                return $0.dueDate < $1.dueDate
            }
            
            return $0.priority > $1.priority
        }
    }
    
    // MARK: Highest Priority
    /// Returns the task with the
    /// highest priority level.
    var highestPriorityTask: AppTask? {
        
        tasks.max {
            $0.priority < $1.priority
        }
    }
    
    // MARK: Task Management
    /// Creates and stores a new task.
    func addTask(
        title: String,
        description: String,
        dueDate: Date,
        dueTime: Date,
        priority: Int
    ) {
        
        guard let uid =
                Auth.auth().currentUser?.uid
        else {
            return
        }
        
        let task = AppTask(
            
            id: UUID().uuidString,
            
            userId: uid,
            
            title: title,
            
            description: description,
            
            dueDate: dueDate,
            
            dueTime: dueTime,
            
            priority: priority,
            
            isCompleted: false,
            
            createdAt: Date()
        )
        
        firestoreService.createTask(
            task: task
        ) { result in
            
            if case let .failure(error) = result {
                
                print(
                    error.localizedDescription
                )
            }
        }
    }
    
    
    // MARK: - Load Tasks

    func loadTasks() {

        firestoreService.stopListening()

        guard let userId =
            AuthService.shared.currentUser?.uid
        else {
            return
        }

        firestoreService.listenForTasks(
            userId: userId
        ) { [weak self] result in

            DispatchQueue.main.async {

                switch result {

                case .success(let tasks):

                    self?.tasks = tasks.sorted {
                        $0.createdAt > $1.createdAt
                    }

                case .failure(let error):

                    print(
                        "Failed to load tasks:",
                        error.localizedDescription
                    )
                }
            }
        }
    }
   
    // MARK: - Update Task

    /// Updates an existing task in Firestore.
    func updateTask(
        id: String,
        title: String,
        description: String,
        dueDate: Date,
        dueTime: Date,
        priority: Int
    ) {

        guard let existingTask =
            tasks.first(
                where: { $0.id == id }
            )
        else {
            return
        }

        var updatedTask = existingTask

        updatedTask.title = title
        updatedTask.description = description
        updatedTask.dueDate = dueDate
        updatedTask.dueTime = dueTime
        updatedTask.priority = priority

        firestoreService.updateTask(
            task: updatedTask
        ) { result in

            switch result {

            case .success:

                print("Task updated")

            case .failure(let error):

                print(
                    "Update Error:",
                    error.localizedDescription
                )
            }
        }
    }
    
    
    
    // MARK: Toggle Task
    /// Toggles the completion status
    /// of the specified task.
    
    func toggleTask(
        _ task: AppTask
    ) {
        
        var updatedTask = task
        
        updatedTask.isCompleted.toggle()
        
        firestoreService.updateTask(
            task: updatedTask
        ) { result in
            
            if case let .failure(error) = result {
                
                print(
                    error.localizedDescription
                )
            }
        }
    }
    
    // MARK: Delete Task
    /// Permanently removes a task.
    func deleteTask(
        _ task: AppTask
    ) {
        
        firestoreService.deleteTask(
            task: task
        ) { result in
            
            if case let .failure(error) = result {
                
                print(
                    error.localizedDescription
                )
            }
        }
    }
    
    
    
    // MARK: Logout
    
    /// Signs the user out of Firebase Authentication
    /// and resets session-related UI state.
    func logout() {
        
        do {
            
            try AuthService.shared.logout()
            
            firestoreService.stopListening()
            
            tasks.removeAll()
            
            searchText = ""
            todayOnlyFilter = false
            selectedDate = Date()
            
            isLoggedOut = true
            
        } catch {
            
            print(
                "Logout Failed:",
                error.localizedDescription
            )
        }
    }
    
    // MARK: Profile Image Management
    /// Stores a selected profile image
    /// in local device storage.
    
    /// Loads the user's saved profile image.
    /// Loads the user's saved profile image.
    func saveProfileImage(
        _ image: UIImage
    ) {
        
        guard let data =
                image.jpegData(
                    compressionQuality: 0.8
                )
        else {
            return
        }
        
        profileImageData = data
        
        UserDefaults.standard.set(
            data,
            forKey: profileImageKey
        )
    }
    
    // MARK: - Load Current User

    /// Retrieves the authenticated
    /// user's profile from Firestore.
    func loadCurrentUser() {

        UserFirestoreService.shared
            .fetchCurrentUser {

                [weak self] result in

                DispatchQueue.main.async {

                    switch result {

                    case .success(let user):

                        self?.currentUser = user
                        self?.userName = user.displayName

                    case .failure(let error):

                        print(
                            "Load User Error:",
                            error.localizedDescription
                        )
                    }
                }
            }
    }
    
    
    // MARK: - Update User Name

    /// Updates the user's display name
    /// inside Firestore and refreshes
    /// the local Profile screen data.
    ///
    /// - Parameter newName:
    /// The updated display name.
    func updateUserName(
        newName: String
    ) {

        guard let userId =
                currentUser?.id
        else {

            return
        }

        UserFirestoreService.shared
            .updateDisplayName(

                userId: userId,

                newName: newName

            ) { [weak self] result in

                DispatchQueue.main.async {

                    switch result {

                    case .success:

                        // Update Local State

                        self?.currentUser?.displayName =
                        newName

                        self?.userName =
                        newName

                    case .failure(let error):

                        print(
                            "Update Name Error:",
                            error.localizedDescription
                        )
                    }
                }
            }
    }
    
    
    /// Loads the user's saved profile image.
    private func loadProfileImage() {
        
        profileImageData =
        UserDefaults.standard.data(
            forKey: profileImageKey
        )
    }
    
    /// Converts stored image data into
    /// a UIImage for display purposes.
    var profileUIImage: UIImage? {
        
        guard let data = profileImageData else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    // MARK: Calendar Helpers
    
    /// Determines whether any task exists
    /// on a specific calendar date.
    func hasTask(on date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        return tasks.contains {
            
            calendar.isDate(
                $0.dueDate,
                inSameDayAs: date
            )
        }
    }
    
    
    
    
    
    // MARK: Cleanup

    deinit {

        firestoreService.stopListening()
    }
    
}

