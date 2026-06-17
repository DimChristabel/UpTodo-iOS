//
//  AboutUsView.swift
//  upToDo
//
//  Created by Maxut Consulting on 16/06/2026.
//

import SwiftUI

// MARK: - AboutUsView

/// Displays information about the application,
/// its purpose, core features, and current version.
///
/// This screen provides users with a brief overview
/// of UpTodo and its productivity-focused functionality.
struct AboutUsView: View {

    // MARK: Properties

    @Environment(\.dismiss)
    private var dismiss

    // MARK: Body

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black
                    .ignoresSafeArea()

                ScrollView {

                    VStack(
                        alignment: .leading,
                        spacing: 24
                    ) {

                        // MARK: Application Branding

                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 100,
                                height: 100
                            )
                            .frame(maxWidth: .infinity)

                        Text("UpTodo")
                            .font(
                                .system(
                                    size: 28,
                                    weight: .bold
                                )
                            )
                            .foregroundColor(.white)

                        // MARK: Application Overview

                        Text("""
                        UpTodo is a productivity and task management application designed to help users stay organized, focused, and productive.

                        Create tasks, manage priorities, schedule activities, and track your progress all in one place.
                        """)
                        .foregroundColor(.gray)
                        .lineSpacing(6)

                        Divider()

                        // MARK: Core Features

                        VStack(
                            alignment: .leading,
                            spacing: 16
                        ) {

                            Label(
                                "Task Management",
                                systemImage: "checkmark.circle.fill"
                            )

                            Label(
                                "Calendar Scheduling",
                                systemImage: "calendar"
                            )

                            Label(
                                "Priority Tracking",
                                systemImage: "flag.fill"
                            )

                            Label(
                                "Focus Mode",
                                systemImage: "timer"
                            )
                        }
                        .foregroundColor(.white)

                        Divider()

                        // MARK: Application Version

                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {

                            Text("Version")
                                .font(.headline)
                                .foregroundColor(.white)

                            Text("1.0.0")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(24)
                }
            }
            .navigationTitle("About Us")
            .navigationBarTitleDisplayMode(.inline)

            // MARK: Navigation Controls

            .toolbar {

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Button("Done") {

                        dismiss()
                    }
                    .foregroundColor(
                        Color("MildPurple")
                    )
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {

    AboutUsView()
        .preferredColorScheme(.dark)
}
