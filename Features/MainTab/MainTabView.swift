//
//  MainTabView.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - AppTab

/// Represents the available tabs within the
/// main application dashboard.
enum AppTab {

    case home
    case calendar
    case focus
    case profile
}

// MARK: - MainTabView

/// Main container view displayed after a user
/// successfully authenticates.
///
/// Responsible for managing tab navigation,
/// displaying the floating action button,
/// and presenting the add task sheet.
struct MainTabView: View {

    // MARK: Properties

    @ObservedObject
    var viewModel: TaskViewModel

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

                    // MARK: Home Tab

                    case .home:

                        HomeView(
                            viewModel: viewModel,
                            onProfileTapped: {
                                selectedTab = .profile
                            }
                        )

                    // MARK: Calendar Tab

                    case .calendar:

                        CalendarView(
                            viewModel: viewModel
                        )

                    // MARK: Focus Tab

                    case .focus:

                        FocusView()

                    // MARK: Profile Tab

                    case .profile:

                        ProfileView(
                            viewModel: viewModel
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

                    viewModel.showAddTaskSheet = true
                }
                .offset(y: -32)
            }
        }

        // MARK: Add Task Sheet

        .sheet(
            isPresented: $viewModel.showAddTaskSheet
        ) {

            AddTaskView(
                viewModel: viewModel
            )
            .presentationDetents([
                .fraction(0.60)
            ])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(24)
        }
    }

    // MARK: Tab Button

    /// Creates a navigation button for the
    /// custom bottom tab bar.
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
        viewModel: TaskViewModel()
    )
    .preferredColorScheme(.dark)
}
