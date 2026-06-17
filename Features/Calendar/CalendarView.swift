//
//  CalendarView.swift
//  upToDo
//
//  Created by Maxut Consulting on 09/06/2026.
//


import SwiftUI

// MARK: - CalendarView

/// Displays tasks in a calendar-based layout.
///
/// Users can navigate between months, select dates,
/// view scheduled tasks, and switch between active
/// and completed task lists.
struct CalendarView: View {

    // MARK: Properties

    @ObservedObject
    var viewModel: TaskViewModel

    @State
    private var showCompleted = false

    @State
    private var selectedTask: AppTask?

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: Screen Header

                Text("Calendar")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.top, 20)

                // MARK: Month Navigation

                HStack {

                    Button {

                        viewModel.moveToPreviousMonth()

                    } label: {

                        Image(systemName: "chevron.left")
                            .font(.headline)
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Text(viewModel.currentMonthTitle)
                        .font(.headline)
                        .foregroundColor(.white)

                    Spacer()

                    Button {

                        viewModel.moveToNextMonth()

                    } label: {

                        Image(systemName: "chevron.right")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)

                // MARK: Week Strip

                ScrollView(
                    .horizontal,
                    showsIndicators: false
                ) {

                    HStack(spacing: 12) {

                        ForEach(
                            viewModel.currentWeekDates,
                            id: \.self
                        ) { date in

                            CalendarDayCard(
                                date: date,
                                selectedDate: $viewModel.selectedDate,
                                hasTask: viewModel.hasTask(on: date)
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                }

                // MARK: Task Filter

                HStack(spacing: 12) {

                    Button {

                        showCompleted = false

                    } label: {

                        Text("Tasks")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(
                                !showCompleted
                                ? Color("MildPurple")
                                : Color.white.opacity(0.08)
                            )
                            .cornerRadius(12)
                    }

                    Button {

                        showCompleted = true

                    } label: {

                        Text("Completed")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(
                                showCompleted
                                ? Color("MildPurple")
                                : Color.white.opacity(0.08)
                            )
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)

                // MARK: Selected Date Tasks

                let displayTasks =
                showCompleted
                ? viewModel.tasksForSelectedDate.filter {
                    $0.isCompleted
                }
                : viewModel.tasksForSelectedDate.filter {
                    !$0.isCompleted
                }

                if displayTasks.isEmpty {

                    // MARK: Empty State

                    Spacer()

                    VStack(spacing: 20) {

                        Image("emptyTask")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)

                        Text("No Tasks")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text(
                            showCompleted
                            ? "No completed tasks for this day"
                            : "No tasks scheduled for this day"
                        )
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }

                    Spacer()

                } else {

                    // MARK: Task List

                    ScrollView {

                        LazyVStack(
                            spacing: 12
                        ) {

                            ForEach(displayTasks) { task in

                                TaskCard(
                                    task: task,

                                    onToggle: {

                                        viewModel.toggleTask(task)
                                    },

                                    onTap: {

                                        selectedTask = task
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        .padding(.bottom, 120)
                    }
                }
            }
        }

        // MARK: Task Details Sheet

        .sheet(
            item: $selectedTask
        ) { task in

            TaskDetailView(
                viewModel: viewModel,
                task: task
            )
        }
    }
}

// MARK: - Preview

#Preview {

    CalendarView(
        viewModel: TaskViewModel()
    )
    .preferredColorScheme(.dark)
}
