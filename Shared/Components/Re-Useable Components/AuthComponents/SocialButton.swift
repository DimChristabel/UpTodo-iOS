//
//  SocialButton.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - SocialButton

/// A reusable button used for social authentication.
///
/// Provides a consistent interface for third-party
/// login providers such as Google, Apple, or other
/// external authentication services.
struct SocialButton: View {

    // MARK: Properties

    /// Text displayed within the button.
    let title: String

    /// SF Symbol representing the authentication provider.
    let icon: String

    /// Action executed when the button is tapped.
    let action: () -> Void

    // MARK: Body

    var body: some View {

        Button(action: action) {

            HStack {

                // MARK: Provider Icon

                Image(systemName: icon)

                // MARK: Provider Title

                Text(title)

                Spacer()
            }
            .foregroundColor(.white)
            .padding()

            // MARK: Button Border

            .overlay {

                RoundedRectangle(
                    cornerRadius: 4
                )
                .stroke(
                    Color.gray.opacity(0.4),
                    lineWidth: 1
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

        SocialButton(
            title: "Continue with Google",
            icon: "globe"
        ) {

        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
