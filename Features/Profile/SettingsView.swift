//
//  SettingsView.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - SettingsView

/// Provides application configuration options
/// including appearance preferences, language,
/// notification settings, and calendar integration.
///
/// This screen serves as the central location for
/// user-specific application settings.
struct SettingsView: View {

    // MARK: Properties

    @Environment(\.dismiss)
    private var dismiss

    @State private var notificationsEnabled = true

    // MARK: Body

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black
                    .ignoresSafeArea()

                ScrollView {

                    VStack(spacing: 24) {

                        // MARK: Appearance Settings

                        settingsCard {

                            SettingsRow(
                                icon: "paintpalette",
                                title: "App Color"
                            )

                            Divider()
                                .overlay(Color.gray.opacity(0.3))

                            SettingsRow(
                                icon: "textformat",
                                title: "Typography"
                            )

                            Divider()
                                .overlay(Color.gray.opacity(0.3))

                            SettingsRow(
                                icon: "globe",
                                title: "Language"
                            )
                        }

                        // MARK: Application Preferences

                        settingsCard {

                            Toggle(
                                "Notifications",
                                isOn: $notificationsEnabled
                            )
                            .tint(Color("MildPurple"))
                            .foregroundColor(.white)

                            Divider()
                                .overlay(Color.gray.opacity(0.3))

                            SettingsRow(
                                icon: "calendar",
                                title: "Google Calendar"
                            )
                        }

                        // MARK: Application Information

                        VStack(spacing: 8) {

                            Text("UpTodo")
                                .font(.headline)
                                .foregroundColor(.white)

                            Text("Version 1.0")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 20)
                    }
                    .padding(24)
                }
            }
            .navigationTitle("Settings")
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
        .preferredColorScheme(.dark)
    }

    // MARK: Settings Card

    /// Creates a reusable container used to group
    /// related settings into visually distinct sections.
    @ViewBuilder
    private func settingsCard<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {

        VStack(spacing: 0) {

            content()
        }
        .padding()
        .background(
            Color.white.opacity(0.06)
        )
        .cornerRadius(16)
    }
}

// MARK: - SettingsRow

/// Reusable row component used throughout the
/// settings screen to display configurable options.
struct SettingsRow: View {

    // MARK: Properties

    let icon: String
    let title: String

    // MARK: Body

    var body: some View {

        HStack {

            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 24)

            Text(title)
                .foregroundColor(.white)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 12)
    }
}

// MARK: - Preview

#Preview {

    SettingsView()
        .preferredColorScheme(.dark)
}
