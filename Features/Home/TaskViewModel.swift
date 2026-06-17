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

    // MARK: UI States

    @Published var showAddTaskSheet = false
    @Published var showChangeNameSheet = false
    @Published var showChangePasswordSheet = false
    @Published var todayOnlyFilter = true
    @Published var isLoggedOut = false

    // MARK: Storage Keys

    private let taskStorageKey = "saved_tasks"
    private let profileImageKey = "profile_image"

    // MARK: Initialization

    init() {

        loadTasks()
        loadProfileImage()

        print("Loaded \(tasks.count) task(s)")
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

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        let task = AppTask(
            id: UUID().uuidString,
            title: title,
            description: description,
            dueDate: dueDate,
            dueTime: formatter.string(from: dueTime),
            priority: priority,
            isCompleted: false,
            createdAt: Date()
        )

        tasks.append(task)

        saveTasks()
    }

    // MARK: Update Task
    /// Updates an existing task.
    func updateTask(
        id: String,
        title: String,
        description: String,
        dueDate: Date,
        dueTime: Date,
        priority: Int
    ) {

        guard let index =
                tasks.firstIndex(
                    where: { $0.id == id }
                )
        else {
            return
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        tasks[index].title = title
        tasks[index].description = description
        tasks[index].dueDate = dueDate
        tasks[index].dueTime = formatter.string(from: dueTime)
        tasks[index].priority = priority

        saveTasks()
    }

    // MARK: Toggle Task
    /// Toggles the completion status
    /// of the specified task.

    func toggleTask(_ task: AppTask) {

        guard let index =
                tasks.firstIndex(
                    where: { $0.id == task.id }
                )
        else {
            return
        }

        tasks[index].isCompleted.toggle()

        saveTasks()

        objectWillChange.send()
    }

    // MARK: Delete Task
    /// Permanently removes a task.
    func deleteTask(_ task: AppTask) {

        tasks.removeAll {
            $0.id == task.id
        }

        saveTasks()
    }

    // MARK: Find Task
    /// Finds a task by its unique identifier.
    func task(with id: String) -> AppTask? {

        tasks.first {
            $0.id == id
        }
    }

    // MARK: User Profile Management

    func changeUserName(_ newName: String) {

        let trimmed =
        newName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmed.isEmpty else {
            return
        }

        userName = trimmed
    }

    // MARK: Logout
    /// Resets session-related state and
    /// returns the user to the welcome flow.
    func logout() {

        isLoggedOut = true

        searchText = ""
        todayOnlyFilter = false
        selectedDate = Date()

        // Tasks stay saved
        // Profile image stays saved
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

    // MARK: Local Persistence
    /// Saves all tasks to UserDefaults.

    private func saveTasks() {

        guard let data =
                try? JSONEncoder().encode(tasks)
        else {
            return
        }

        UserDefaults.standard.set(
            data,
            forKey: taskStorageKey
        )
    }

    // MARK: Load Tasks
    /// Loads previously saved tasks
    /// from UserDefaults.
    private func loadTasks() {

        guard let data =
                UserDefaults.standard.data(
                    forKey: taskStorageKey
                )
        else {

            tasks = []
            return
        }

        guard let decoded =
                try? JSONDecoder().decode(
                    [AppTask].self,
                    from: data
                )
        else {

            tasks = []
            return
        }

        tasks = decoded
    }
}


