//
//  SocialAuthButton.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - SocialAuthButton

/// A reusable authentication button for
/// third-party sign-in providers.
///
/// Supports both SF Symbols and custom asset
/// icons, making it suitable for providers
/// such as Google, Apple, Facebook, and other
/// external authentication services.
struct SocialAuthButton: View {

    // MARK: Properties

    /// Text displayed inside the button.
    let title: String

    /// Optional SF Symbol displayed as the
    /// authentication provider icon.
    let systemIcon: String?

    /// Optional custom asset image displayed
    /// as the authentication provider icon.
    let assetIcon: String?

    /// Action executed when the button is tapped.
    let action: () -> Void

    // MARK: Body

    var body: some View {

        Button(action: action) {

            HStack(spacing: 12) {

                // MARK: System Icon

                if let systemIcon {

                    Image(systemName: systemIcon)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }

                // MARK: Asset Icon

                if let assetIcon {

                    Image(assetIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 20,
                            height: 20
                        )
                }

                // MARK: Provider Title

                Text(title)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)

            // MARK: Button Border

            .overlay {

                RoundedRectangle(
                    cornerRadius: 4
                )
                .stroke(
                    Color.white.opacity(0.2),
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

        VStack(spacing: 16) {

            SocialAuthButton(
                title: "Continue with Apple",
                systemIcon: "apple.logo",
                assetIcon: nil
            ) {

            }

            SocialAuthButton(
                title: "Continue with Google",
                systemIcon: nil,
                assetIcon: "googleIcon"
            ) {

            }
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
