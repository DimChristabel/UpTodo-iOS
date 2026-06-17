//
//  AddTaskView.swift
//  upToDo
//
//  Created by Maxut Consulting on 31/05/2026.
//

import SwiftUI

// MARK: - AddTaskView

/// Provides an interface for creating new tasks.
///
/// Users can enter task details, select a due date,
/// choose a priority level, and save the task to
/// the application's task collection.
struct AddTaskView: View {

    // MARK: Properties

    @Environment(\.dismiss)
    private var dismiss

    @ObservedObject
    var viewModel: TaskViewModel

    @State private var title = ""
    @State private var description = ""

    @State private var dueDate = Date()
    @State private var dueTime = Date()

    @State private var selectedPriority = 1

    @State private var showDatePicker = false
    @State private var showPrioritySheet = false

    // MARK: Body

    var body: some View {

        ZStack {

            Color(
                red: 0.14,
                green: 0.14,
                blue: 0.14
            )
            .ignoresSafeArea()

            VStack(
                alignment: .leading,
                spacing: 0
            ) {

                // MARK: Header

                Text("Add Task")
                    .font(
                        .system(
                            size: 20,
                            weight: .medium
                        )
                    )
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)

                Divider()
                    .overlay(
                        Color.gray.opacity(0.3)
                    )
                    .padding(.top, 16)

                // MARK: Task Title Input

                TextField(
                    "",
                    text: $title,
                    prompt: Text(
                        "Do math homework"
                    )
                    .foregroundColor(.gray)
                )
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.top, 24)

                // MARK: Task Description Input

                TextField(
                    "",
                    text: $description,
                    prompt: Text(
                        "Description"
                    )
                    .foregroundColor(.gray),
                    axis: .vertical
                )
                .foregroundColor(.white)
                .lineLimit(3)
                .padding(.horizontal, 24)
                .padding(.top, 20)

                Divider()
                    .overlay(
                        Color.gray.opacity(0.3)
                    )
                    .padding(.top, 32)

                // MARK: Task Actions Toolbar

                HStack {

                    // MARK: Due Date Selection

                    Button {

                        showDatePicker = true

                    } label: {

                        Image(systemName: "calendar")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.6))
                    }

                    Spacer()

                    // MARK: Priority Selection

                    Button {

                        showPrioritySheet = true

                    } label: {

                        HStack(spacing: 6) {

                            Image(systemName: "flag.fill")

                            Text(
                                "\(selectedPriority)"
                            )
                        }
                        .foregroundColor(
                            Color("MildPurple")
                        )
                    }

                    Spacer()

                    // MARK: Save Task

                    Button {

                        saveTask()

                    } label: {

                        Image(
                            systemName:
                                "paperplane.fill"
                        )
                        .font(.title3)
                        .foregroundColor(
                            title.trimmingCharacters(
                                in: .whitespacesAndNewlines
                            ).isEmpty
                            ? .gray
                            : Color("MildPurple")
                        )
                    }
                    .disabled(
                        title.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 18)
            }
        }

        // MARK: Date Picker Sheet

        .sheet(
            isPresented: $showDatePicker
        ) {

            DatePickerSheet(
                selectedDate: $dueDate,
                selectedTime: $dueTime
            )
        }

        // MARK: Priority Picker Sheet

        .sheet(
            isPresented: $showPrioritySheet
        ) {

            PriorityPickerView(
                selectedPriority: $selectedPriority
            )
        }
    }

    // MARK: Task Creation

    /// Validates user input and creates a new task.
    ///
    /// The task is passed to the TaskViewModel and
    /// the sheet is dismissed upon successful creation.
    private func saveTask() {

        let cleanTitle =
        title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanTitle.isEmpty else {
            return
        }

        viewModel.addTask(
            title: cleanTitle,
            description: description,
            dueDate: dueDate,
            dueTime: dueTime,
            priority: selectedPriority
        )

        viewModel.showAddTaskSheet = false

        dismiss()
    }
}

// MARK: - Preview

#Preview {

    AddTaskView(
        viewModel: TaskViewModel()
    )
    .preferredColorScheme(.dark)
}
