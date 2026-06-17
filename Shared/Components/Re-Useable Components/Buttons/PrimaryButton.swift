//
//  PrimaryButton.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - PrimaryButton

/// A reusable primary action button used
/// throughout the application.
///
/// Displays a prominent call-to-action using
/// the application's primary brand color and
/// executes a provided action when tapped.
struct PrimaryButton: View {

    // MARK: Properties

    /// Text displayed inside the button.
    let title: String

    /// Action executed when the button is tapped.
    let action: () -> Void

    // MARK: Body

    var body: some View {

        Button(action: action) {

            Text(title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(
                    Color("MildPurple")
                )
                .cornerRadius(8)
        }
    }
}

// MARK: - Preview

#Preview {

    ZStack {

        Color.black
            .ignoresSafeArea()

        PrimaryButton(
            title: "Continue"
        ) {

            print("Button tapped")
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
