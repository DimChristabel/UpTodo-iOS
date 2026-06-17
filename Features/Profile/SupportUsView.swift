//
//  SupportUsView.swift
//  upToDo
//
//  Created by Maxut Consulting on 17/06/2026.
//

import SwiftUI

// MARK: - SupportUsView

/// Displays ways users can support the application
/// through ratings, referrals, and feedback.
///
/// This screen encourages user engagement and
/// provides opportunities to contribute to the
/// continued improvement of UpTodo.
struct SupportUsView: View {

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
                        spacing: 24
                    ) {

                        // MARK: Support Header

                        Image(
                            systemName: "heart.fill"
                        )
                        .font(.system(size: 70))
                        .foregroundColor(
                            Color("MildPurple")
                        )

                        Text(
                            "Support UpTodo"
                        )
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                        Text(
                            """
                            Thank you for using UpTodo.

                            Your support helps us continue improving the app and delivering better productivity tools.
                            """
                        )
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                        // MARK: Support Options

                        supportCard(
                            title: "Rate the App",
                            description:
                                "Leave a rating and review on the App Store."
                        )

                        supportCard(
                            title: "Share with Friends",
                            description:
                                "Recommend UpTodo to family and friends."
                        )

                        supportCard(
                            title: "Send Feedback",
                            description:
                                "Help us improve by sharing suggestions."
                        )
                    }
                    .padding()
                }
            }
            .navigationTitle("Support Us")
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

    // MARK: Support Card

    /// Creates a reusable information card used
    /// to present different ways users can support
    /// the application.
    private func supportCard(
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

    SupportUsView()
        .preferredColorScheme(.dark)
}
