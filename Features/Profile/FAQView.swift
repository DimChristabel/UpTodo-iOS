//
//  FAQView.swift
//  upToDo
//
//  Created by Maxut Consulting on 16/06/2026.
//

import SwiftUI

// MARK: - FAQView

/// Displays frequently asked questions about the application.
///
/// This screen provides users with quick answers to
/// common questions related to task management,
/// account settings, and application usage.
struct FAQView: View {

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
                        spacing: 16
                    ) {

                        // MARK: Frequently Asked Questions

                        FAQCard(
                            question: "How do I add a task?",
                            answer: "Tap the + button at the bottom center of the screen and fill in your task details."
                        )

                        FAQCard(
                            question: "How do I edit a task?",
                            answer: "Tap on any task card to open its details and make changes."
                        )

                        FAQCard(
                            question: "How do I mark a task as completed?",
                            answer: "Tap the circle icon beside a task to mark it as completed."
                        )

                        FAQCard(
                            question: "How do I change my account name?",
                            answer: "Go to Profile → Change Account Name."
                        )

                        FAQCard(
                            question: "How do I change my password?",
                            answer: "Go to Profile → Change Password."
                        )

                        FAQCard(
                            question: "Will my tasks be deleted when I logout?",
                            answer: "No. Tasks remain saved on the device and will still be available when you log back in."
                        )

                        FAQCard(
                            question: "How do I view tasks for a specific day?",
                            answer: "Open the Calendar tab and select the desired date."
                        )
                    }
                    .padding(24)
                }
            }
            .navigationTitle("FAQ")
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

// MARK: - FAQCard

/// Reusable expandable card used to display
/// a question and its corresponding answer.
///
/// Tapping the card header expands or collapses
/// the answer section with animation.
struct FAQCard: View {

    // MARK: Properties

    let question: String
    let answer: String

    @State
    private var isExpanded = false

    // MARK: Body

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Button {

                withAnimation {

                    isExpanded.toggle()
                }

            } label: {

                HStack {

                    Text(question)
                        .font(.headline)
                        .foregroundColor(.white)

                    Spacer()

                    Image(
                        systemName:
                            isExpanded
                            ? "chevron.up"
                            : "chevron.down"
                    )
                    .foregroundColor(
                        Color("MildPurple")
                    )
                }
            }

            if isExpanded {

                Text(answer)
                    .foregroundColor(.gray)
                    .transition(.opacity)
            }
        }
        .padding(16)
        .background(
            Color.white.opacity(0.06)
        )
        .cornerRadius(12)
    }
}

// MARK: - Preview

#Preview {

    FAQView()
        .preferredColorScheme(.dark)
}
