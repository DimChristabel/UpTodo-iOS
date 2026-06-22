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
    
    
    
    // MARK: Search & Filtering
    @Published var searchText = ""
    
    // MARK: Task Collection
    @Published var tasks: [AppTask] = []
    
    // MARK: Calendar State
    @Published var selectedDate = Date()
    
    // MARK: UI States
    @Published var showAddTaskSheet = false
    @Published var todayOnlyFilter = true
  
    
    // MARK: Storage Keys
    private let profileImageKey = "profile_image"
    
    // MARK: Firestore
    private let firestoreService =
    FirestoreService.shared
    
    // MARK: Initialization
    
    init() {

        if Auth.auth().currentUser != nil {

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
    
    // MARK: Move To Previous Month
    /// Moves calendar selection
    /// to the previous month.
    func moveToPreviousMonth() {

        let calendar = Calendar.current

        guard let previousMonth =
            calendar.date(
                byAdding: .month,
                value: -1,
                to: selectedDate
            )
        else {
            return
        }

        let components =
        calendar.dateComponents(
            [.year, .month],
            from: previousMonth
        )

        selectedDate =
        calendar.date(
            from: components
        ) ?? previousMonth
    }
    
   
    // MARK: Move To Next Month
    /// Moves calendar selection
    /// to the next month.
   func moveToNextMonth() {

        let calendar = Calendar.current

        guard let nextMonth =
            calendar.date(
                byAdding: .month,
                value: 1,
                to: selectedDate
            )
        else {
            return
        }

        let components =
        calendar.dateComponents(
            [.year, .month],
            from: nextMonth
        )

        selectedDate =
        calendar.date(
            from: components
        ) ?? nextMonth
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
        ) { [weak self] result in

            switch result {

            case .success:

                self?.loadTasks()

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
    
    
    // MARK: Toggle Task Completion

    /// Toggles a task's completion state.
    func toggleTaskCompletion(
        task: AppTask
    ) {

        FirestoreService.shared
            .toggleTaskCompletion(
                task: task
            ) { result in

                switch result {

                case .success:

                    break

                case .failure(let error):

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

        } catch {

            print(
                "Logout Failed:",
                error.localizedDescription
            )
        }
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
    
   
    
}

