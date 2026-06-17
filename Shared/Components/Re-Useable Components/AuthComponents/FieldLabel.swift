//
//  FieldLabel.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - AuthTextField

/// A reusable text input component used throughout
/// the authentication flow.
///
/// Provides a consistent appearance for standard
/// text entry fields such as username, email,
/// or other non-secure user credentials.
struct AuthTextField: View {

    // MARK: Properties

    /// Label displayed above the text field.
    let title: String

    /// Placeholder text displayed when
    /// no value has been entered.
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
                .font(.system(size: 16))

            // MARK: Text Input

            TextField(
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

        AuthTextField(
            title: "Username",
            placeholder: "Enter username",
            text: .constant("")
        )
        .padding()
    }
    .preferredColorScheme(.dark)
}
