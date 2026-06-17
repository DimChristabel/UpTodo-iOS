//
//  TaskCard.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - TaskCard

/// Displays a summary of a task within task lists.
///
/// Shows task information including title,
/// description, due date, due time, completion
/// status, and priority level. Users can mark
/// tasks as complete or open task details.
struct TaskCard: View {

    // MARK: Properties

    let task: AppTask

    let onToggle: () -> Void

    let onTap: () -> Void

    // MARK: Body

    var body: some View {

        HStack(spacing: 12) {

            // MARK: Completion Toggle

            Button {

                onToggle()

            } label: {

                Image(
                    systemName:
                        task.isCompleted
                        ? "checkmark.circle.fill"
                        : "circle"
                )
                .font(.title3)
                .foregroundColor(
                    task.isCompleted
                    ? Color("MildPurple")
                    : .gray
                )
            }
            .buttonStyle(.plain)

            // MARK: Task Information

            VStack(
                alignment: .leading,
                spacing: 8
            ) {

                Text(task.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .strikethrough(
                        task.isCompleted,
                        color: .gray
                    )

                if !task.description.isEmpty {

                    Text(task.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }

                // MARK: Due Date & Time

                HStack(spacing: 6) {

                    Text(
                        task.dueDate.formatted(
                            date: .abbreviated,
                            time: .omitted
                        )
                    )

                    Text("•")

                    Text(task.dueTime)
                }
                .font(.caption2)
                .foregroundColor(.gray)
            }

            Spacer()

            // MARK: Priority Indicator

            HStack(spacing: 4) {

                Image(systemName: "flag.fill")

                Text("\(task.priority)")
            }
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(
                PriorityColorHelper.color(
                    for: task.priority
                )
            )
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Color.white.opacity(0.08)
            )
            .cornerRadius(8)

            // MARK: Navigation Indicator

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding(16)
        .background(
            Color.white.opacity(0.06)
        )
        .cornerRadius(12)

        // Ensures the entire card is tappable
        .contentShape(Rectangle())

        // Opens task details when selected
        .onTapGesture {

            onTap()
        }
    }
}

// MARK: - Preview

#Preview {

    TaskCard(
        task: AppTask(
            id: UUID().uuidString,
            title: "Complete SwiftUI Project",
            description: "Build UpTodo App",
            dueDate: Date(),
            dueTime: "14:30",
            priority: 8,
            isCompleted: false,
            createdAt: Date()
        ),
        onToggle: {},
        onTap: {}
    )
    .padding()
    .background(Color.black)
}
