//
//  SecureInputField.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - AuthSecureField

/// A reusable secure text input component used
/// throughout the authentication flow.
///
/// Provides a consistent interface for entering
/// sensitive information such as passwords while
/// automatically hiding the entered characters.
struct AuthSecureField: View {

    // MARK: Properties

    /// Label displayed above the secure input field.
    let title: String

    /// Placeholder text displayed when no value
    /// has been entered.
    let placeholder: String

    /// Bound value entered by the user.
    @Binding var text: String

    // MARK: Body

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            // MARK: Field Label

            Text(title)
                .foregroundColor(.white)

            // MARK: Secure Input

            SecureField(
                placeholder,
                text: $text
            )
            .foregroundColor(.white)
            .padding()
            .background(
                Color.white.opacity(0.05)
            )

            // MARK: Field Border

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

        AuthSecureField(
            title: "Password",
            placeholder: "Enter password",
            text: .constant("")
        )
        .padding()
    }
    .preferredColorScheme(.dark)
}
