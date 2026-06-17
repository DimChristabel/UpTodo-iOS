//
//  Task.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//

import Foundation

// MARK: - AppTask

/// Represents a task created by a user.
///
/// Stores task information including its title,
/// description, due date, priority level,
/// completion status, and creation timestamp.
struct AppTask: Identifiable, Codable {

    // MARK: Properties

    /// Unique identifier for the task.
    var id: String

    /// Short title displayed in task lists.
    var title: String

    /// Additional details about the task.
    var description: String

    /// Date on which the task is due.
    var dueDate: Date

    /// Due time displayed to the user.
    var dueTime: String

    /// Task priority level (1–10).
    var priority: Int

    /// Indicates whether the task has been completed.
    var isCompleted: Bool

    /// Timestamp when the task was created.
    var createdAt: Date
}
