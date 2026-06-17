//
//  TaskRowView.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - TaskRowView

/// Displays a compact representation of a task.
///
/// Used within task lists to present task details,
/// completion status, and quick interaction for
/// marking tasks as completed or incomplete.
struct TaskRowView: View {

    // MARK: Properties

    let task: AppTask

    @ObservedObject
    var viewModel: TaskViewModel

    // MARK: Body

    var body: some View {

        HStack {

            // MARK: Completion Toggle

            Button {

                viewModel.toggleTask(task)

            } label: {

                Image(
                    systemName:
                        task.isCompleted
                    ? "checkmark.circle.fill"
                    : "circle"
                )
                .foregroundColor(
                    task.isCompleted
                    ? Color("MildPurple")
                    : .gray
                )
            }

            // MARK: Task Information

            VStack(
                alignment: .leading
            ) {

                Text(task.title)
                    .foregroundColor(.white)

                Text(task.description)
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(task.dueTime)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()

        // MARK: Task Card Styling

        .background(
            Color.white.opacity(0.06)
        )
        .cornerRadius(6)
    }
}

// MARK: - Preview

#Preview {

    ZStack {

        Color.black
            .ignoresSafeArea()

        TaskRowView(
            task: AppTask(
                id: UUID().uuidString,
                title: "Sample Task",
                description: "Complete project documentation",
                dueDate: Date(),
                dueTime: "14:30",
                priority: 5,
                isCompleted: false,
                createdAt: Date()
            ),
            viewModel: TaskViewModel()
        )
        .padding()
    }
    .preferredColorScheme(.dark)
}
