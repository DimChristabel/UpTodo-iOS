//
//  InputField.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - InputField

/// A reusable input component for collecting
/// user text input.
///
/// Supports both standard text entry and
/// secure text entry, making it suitable for
/// forms, authentication screens, and profile
/// management views.
struct InputField: View {

    // MARK: Properties

    /// Label displayed above the input field.
    let title: String

    /// Bound value entered by the user.
    @Binding var text: String

    /// Determines whether the field should
    /// hide user input.
    var isSecure: Bool = false

    // MARK: Body

    var body: some View {

        VStack(alignment: .leading) {

            // MARK: Field Label

            Text(title)
                .foregroundColor(.white)

            // MARK: Input Field

            if isSecure {

                SecureField(
                    "",
                    text: $text
                )
                .padding()
                .background(
                    Color.white.opacity(0.05)
                )
                .cornerRadius(8)

            } else {

                TextField(
                    "",
                    text: $text
                )
                .padding()
                .background(
                    Color.white.opacity(0.05)
                )
                .cornerRadius(8)
            }
        }
    }
}

// MARK: - Preview

#Preview {

    ZStack {

        Color.black
            .ignoresSafeArea()

        VStack(spacing: 20) {

            InputField(
                title: "Username",
                text: .constant("")
            )

            InputField(
                title: "Password",
                text: .constant(""),
                isSecure: true
            )
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
