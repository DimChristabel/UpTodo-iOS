//
//  HelpAndFeedbackView.swift
//  upToDo
//
//  Created by Maxut Consulting on 17/06/2026.
//

import SwiftUI

// MARK: - HelpAndFeedbackView

/// Provides users with assistance, frequently asked
/// questions, and support contact information.
///
/// This screen helps users understand common app
/// functionality and provides guidance when issues occur.
struct HelpAndFeedbackView: View {

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

                        // MARK: Introduction

                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {

                            Text("Need Help?")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text(
                                "We're here to help you stay productive and organized."
                            )
                            .foregroundColor(.gray)
                        }

                        // MARK: Help Topics

                        helpCard(
                            title: "How do I create a task?",
                            description:
                                "Tap the + button at the bottom of the screen, enter your task details and save."
                        )

                        helpCard(
                            title: "How do I mark a task complete?",
                            description:
                                "Tap the circle beside a task to mark it as completed."
                        )

                        helpCard(
                            title: "How do I edit a task?",
                            description:
                                "Tap any task card to open its details and update the information."
                        )

                        helpCard(
                            title: "Contact Support",
                            description:
                                "Email: support@uptodo.app"
                        )
                    }
                    .padding()
                }
            }
            .navigationTitle("Help & Feedback")
            .navigationBarTitleDisplayMode(.inline)

            // MARK: Navigation Controls

            .toolbar {

                ToolbarItem(
                    placement: .topBarLeading
                ) {

                    Button("Close") {

                        dismiss()
                    }
                    .foregroundColor(
                        Color("MildPurple")
                    )
                }
            }
        }
    }

    // MARK: Help Card

    /// Creates a reusable information card used
    /// throughout the help and feedback screen.
    private func helpCard(
        title: String,
        description: String
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(title)
                .font(.headline)
                .foregroundColor(.white)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            Color.white.opacity(0.08)
        )
        .cornerRadius(12)
    }
}

// MARK: - Preview

#Preview {

    HelpAndFeedbackView()
        .preferredColorScheme(.dark)
}
