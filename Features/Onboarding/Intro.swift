//
//  Intro.swift
//  upToDo
//
//  Created by Maxut Consulting on 26/05/2026.
//

import SwiftUI

// MARK: - IntroView

/// Displays the application's splash screen.
///
/// This view serves as the initial entry point
/// of the application and presents the UpTodo
/// branding before transitioning to the
/// onboarding experience.
struct IntroView: View {

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            // MARK: Application Logo

            Image("appLogo")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 120,
                    height: 120
                )
        }
    }
}

// MARK: - Preview

#Preview {

    IntroView()
        .preferredColorScheme(.dark)
}
