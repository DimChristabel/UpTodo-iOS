//
//  Task.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//

import Foundation

// MARK: - AppTask

/// Represents a task belonging to
/// an authenticated application user.
struct AppTask: Identifiable, Codable {

    // MARK: Properties

    var id: String

    var userId: String

    var title: String

    var description: String

    var dueDate: Date

    var dueTime: Date

    var priority: Int

    var isCompleted: Bool

    var createdAt: Date
}
