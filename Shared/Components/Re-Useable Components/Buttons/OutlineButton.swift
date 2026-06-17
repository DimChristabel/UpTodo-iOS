//
//  OutlineButton.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - OutlineButton

/// A reusable secondary action button used
/// throughout the application.
///
/// Displays an outlined style that visually
/// differentiates secondary actions from the
/// application's primary call-to-action buttons.
struct OutlineButton: View {

    // MARK: Properties

    /// Text displayed inside the button.
    let title: String

    /// Action executed when the button is tapped.
    let action: () -> Void

    // MARK: Body

    var body: some View {

        Button(action: action) {

            Text(title)
                .font(
                    .system(
                        size: 16,
                        weight: .medium
                    )
                )
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)

                // MARK: Button Border

                .overlay {

                    RoundedRectangle(
                        cornerRadius: 4
                    )
                    .stroke(
                        Color("MildPurple"),
                        lineWidth: 1.5
                    )
                }
        }
    }
}

// MARK: - Preview

#Preview {

    ZStack {

        Color.black
            .ignoresSafeArea()

        OutlineButton(
            title: "Create Account"
        ) {

            print("Button tapped")
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
