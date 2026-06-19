//
//  EditTaskView.swift
//  upToDo
//
//  Created by Maxut Consulting on 16/06/2026.
//



import SwiftUI

// MARK: - EditTaskView

/// Allows users to modify an existing task.
///
/// Users can update the task title, description,
/// due date, due time, and priority before saving
/// the changes back to the TaskViewModel.
struct EditTaskView: View {

    // MARK: Properties

    @Environment(\.dismiss)
    private var dismiss

    @ObservedObject
    var viewModel: TaskViewModel

    let task: AppTask

    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var dueTime = Date()
    @State private var selectedPriority = 1

    // MARK: Body

    var body: some View {

        NavigationStack {

            Form {

                // MARK: Task Title

                Section("Title") {

                    TextField(
                        "Title",
                        text: $title
                    )
                }

                // MARK: Task Description

                Section("Description") {

                    TextField(
                        "Description",
                        text: $description
                    )
                }

                // MARK: Due Date

                Section("Date") {

                    DatePicker(
                        "Date",
                        selection: $dueDate,
                        displayedComponents: .date
                    )
                }

                // MARK: Due Time

                Section("Time") {

                    DatePicker(
                        "Time",
                        selection: $dueTime,
                        displayedComponents: .hourAndMinute
                    )
                }
            }

            .navigationTitle("Edit Task")

            // MARK: Navigation Actions

            .toolbar {

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Button("Save") {

                        saveChanges()
                    }
                }
            }
        }

        // MARK: Initial Data Load

        .onAppear {

            title = task.title
            description = task.description
            dueDate = task.dueDate
            dueTime = task.dueTime
            selectedPriority = task.priority
        }
    }

    // MARK: Task Update

    /// Updates the selected task with the
    /// modified values and dismisses the screen.
    private func saveChanges() {

        viewModel.updateTask(
            id: task.id,
            title: title,
            description: description,
            dueDate: dueDate,
            dueTime: dueTime,
            priority: selectedPriority
        )

        dismiss()
    }
}

// MARK: - Preview

#Preview {

    EditTaskView(
        viewModel: TaskViewModel(),
        task: AppTask(
            id: UUID().uuidString,
            userId: "preview-user",
            title: "Sample Task",
            description: "Sample Description",
            dueDate: Date(),
            dueTime: Date(),
            priority: 1,
            isCompleted: false,
            createdAt: Date()
        )
    )
}
