//
//  TaskDetailView.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//
import SwiftUI

// MARK: - TaskDetailView

/// Displays the details of an existing task.
///
/// Users can modify task information, update
/// priority levels, mark tasks as completed,
/// and delete tasks when necessary.
struct TaskDetailView: View {

    // MARK: Properties

    @Environment(\.dismiss)
    private var dismiss

    @ObservedObject
    var viewModel: TaskViewModel

    let task: AppTask

    @State private var title: String
    @State private var description: String
    @State private var dueDate: Date
    @State private var dueTime: Date
    @State private var priority: Int

    @State private var showDeleteAlert = false
    @State private var showPrioritySheet = false

    // MARK: Initializer

    init(
        viewModel: TaskViewModel,
        task: AppTask
    ) {

        self.viewModel = viewModel
        self.task = task

        _title = State(
            initialValue: task.title
        )

        _description = State(
            initialValue: task.description
        )

        _dueDate = State(
            initialValue: task.dueDate
        )

        _dueTime = State(
            initialValue: task.dueTime
        )

        _priority = State(
            initialValue: task.priority
        )
    }

    // MARK: Body

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black
                    .ignoresSafeArea()

                ScrollView {

                    VStack(
                        alignment: .leading,
                        spacing: 20
                    ) {

                        // MARK: Task Title

                        TextField(
                            "Task title",
                            text: $title
                        )
                        .padding()
                        .background(
                            Color.white.opacity(0.08)
                        )
                        .cornerRadius(12)
                        .foregroundColor(.white)

                        // MARK: Task Description

                        TextField(
                            "Description",
                            text: $description,
                            axis: .vertical
                        )
                        .padding()
                        .background(
                            Color.white.opacity(0.08)
                        )
                        .cornerRadius(12)
                        .foregroundColor(.white)

                        // MARK: Due Date

                        DatePicker(
                            "Due Date",
                            selection: $dueDate,
                            displayedComponents: .date
                        )
                        .foregroundColor(.white)

                        // MARK: Due Time

                        DatePicker(
                            "Due Time",
                            selection: $dueTime,
                            displayedComponents: .hourAndMinute
                        )
                        .foregroundColor(.white)

                        // MARK: Priority Selection

                        Button {

                            showPrioritySheet = true

                        } label: {

                            HStack {

                                Text("Priority")
                                    .foregroundColor(.white)

                                Spacer()

                                HStack {

                                    Image(
                                        systemName: "flag.fill"
                                    )

                                    Text(
                                        "\(priority)"
                                    )
                                }
                                .foregroundColor(
                                    PriorityColorHelper.color(
                                        for: priority
                                    )
                                )
                            }
                        }

                        // MARK: Completion Action

                        Button {

                            viewModel.toggleTask(task)

                        } label: {

                            Text(
                                task.isCompleted
                                ? "Mark Incomplete"
                                : "Mark Complete"
                            )
                            .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(
                            Color("MildPurple")
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)

                        // MARK: Delete Task

                        Button {

                            showDeleteAlert = true

                        } label: {

                            Text("Delete Task")
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Task Details")
            .navigationBarTitleDisplayMode(.inline)

            // MARK: Navigation Actions

            .toolbar {

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Button("Save") {

                        saveChanges()
                    }
                    .foregroundColor(
                        Color("MildPurple")
                    )
                }
            }

            // MARK: Priority Picker Sheet

            .sheet(
                isPresented: $showPrioritySheet
            ) {

                PriorityPickerView(
                    selectedPriority: $priority
                )
            }

            // MARK: Delete Confirmation Alert

            .alert(
                "Delete Task?",
                isPresented: $showDeleteAlert
            ) {

                Button(
                    "Delete",
                    role: .destructive
                ) {

                    viewModel.deleteTask(task)

                    dismiss()
                }

                Button(
                    "Cancel",
                    role: .cancel
                ) { }
            }
        }
    }

    // MARK: Task Update

    private func saveChanges() {

        viewModel.updateTask(
            id: task.id,
            title: title,
            description: description,
            dueDate: dueDate,
            dueTime: dueTime,
            priority: priority
        )

        dismiss()
    }
}

// MARK: - Preview

#Preview {

    TaskDetailView(
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
    .preferredColorScheme(.dark)
}
