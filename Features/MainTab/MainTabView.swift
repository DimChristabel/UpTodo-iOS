//
//  MainTabView.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - AppTab

enum AppTab {

    case home
    case calendar
    case focus
    case profile
}

// MARK: - MainTabView

struct MainTabView: View {

    // MARK: Properties

    @ObservedObject
    var taskViewModel: TaskViewModel

    @ObservedObject
    var profileViewModel: ProfileViewModel

    @State
    private var selectedTab: AppTab = .home

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: Screen Content

                Group {

                    switch selectedTab {

                    case .home:

                        HomeView(
                            viewModel: taskViewModel,
                            onProfileTapped: {
                                selectedTab = .profile
                            }
                        )

                    case .calendar:

                        CalendarView(
                            viewModel: taskViewModel
                        )

                    case .focus:

                        FocusView()

                    case .profile:

                        ProfileView(
                            profileViewModel: profileViewModel,
                            taskViewModel: taskViewModel
                        )
                    }
                }

                // MARK: Bottom Navigation Bar

                HStack {

                    tabButton(
                        icon: "house.fill",
                        title: "Index",
                        tab: .home
                    )

                    tabButton(
                        icon: "calendar",
                        title: "Calendar",
                        tab: .calendar
                    )

                    Spacer()
                        .frame(width: 72)

                    tabButton(
                        icon: "clock.fill",
                        title: "Focus",
                        tab: .focus
                    )

                    tabButton(
                        icon: "person.fill",
                        title: "Profile",
                        tab: .profile
                    )
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 28)
                .background(
                    Color(
                        red: 0.14,
                        green: 0.14,
                        blue: 0.14
                    )
                )
            }

            // MARK: Floating Action Button

            VStack {

                Spacer()

                FABButton {

                    taskViewModel.showAddTaskSheet = true

                }
                .offset(y: -32)
            }
        }

        // MARK: Add Task Sheet

        .sheet(
            isPresented: $taskViewModel.showAddTaskSheet
        ) {

            AddTaskView(
                viewModel: taskViewModel
            )
            .presentationDetents([
                .fraction(0.60)
            ])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(24)
        }
    }

    // MARK: Tab Button

    @ViewBuilder
    private func tabButton(
        icon: String,
        title: String,
        tab: AppTab
    ) -> some View {

        Button {

            selectedTab = tab

        } label: {

            VStack(spacing: 4) {

                Image(systemName: icon)
                    .font(.title3)

                Text(title)
                    .font(.caption2)
            }
            .foregroundColor(
                selectedTab == tab
                ? Color("MildPurple")
                : .gray
            )
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Preview

#Preview {

    MainTabView(
        taskViewModel: TaskViewModel(),
        profileViewModel: ProfileViewModel()
    )
    .preferredColorScheme(.dark)
}
