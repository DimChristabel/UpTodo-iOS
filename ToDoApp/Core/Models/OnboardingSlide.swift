//
//  OnboardingSlide.swift.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//

import Foundation

// MARK: - OnboardingSlide

/// Represents a single onboarding screen shown
/// during the user's first launch experience.
struct OnboardingSlide: Identifiable {

    // MARK: Properties

    /// Unique identifier used by SwiftUI lists and views.
    let id = UUID()

    /// Name of the onboarding illustration asset.
    let imageName: String

    /// Main heading displayed on the onboarding screen.
    let title: String

    /// Supporting text that explains the feature.
    let subtitle: String
}
