//
//  EmptyHomeView.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - EmptyHomeView

/// Displays the empty state shown when no tasks
/// are available on the Home screen.
///
/// Encourages users to create their first task
/// and provides visual guidance through an
/// illustration and instructional text.
struct EmptyHomeView: View {

    // MARK: Body

    var body: some View {

        VStack(spacing: 0) {

            Spacer()

            // MARK: Empty State Illustration

            Image("emptyTask")
                .resizable()
                .scaledToFit()
                .frame(
                    maxWidth: 320,
                    maxHeight: 260
                )

            Spacer()
                .frame(height: 40)

            // MARK: Empty State Title

            Text(
                "What do you want to do today?"
            )
            .font(
                .system(
                    size: 20,
                    weight: .medium
                )
            )
            .foregroundColor(.white)
            .multilineTextAlignment(.center)

            Spacer()
                .frame(height: 10)

            // MARK: Empty State Description

            Text(
                "Tap + to add your tasks"
            )
            .font(.system(size: 16))
            .foregroundColor(
                Color.white.opacity(0.6)
            )
            .multilineTextAlignment(.center)

            Spacer()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}

// MARK: - Preview

#Preview {

    ZStack {

        Color.black
            .ignoresSafeArea()

        EmptyHomeView()
    }
    .preferredColorScheme(.dark)
}
