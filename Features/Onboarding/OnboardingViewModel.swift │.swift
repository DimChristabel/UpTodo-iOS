//
//  OnboardingViewModel.swift │.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//
import Foundation
import Combine

// MARK: - OnboardingViewModel

/// Manages the state and content of the onboarding flow.
///
/// Responsible for providing onboarding slides and
/// tracking the user's current position within the
/// onboarding experience.
final class OnboardingViewModel: ObservableObject {

    // MARK: Onboarding Content

    /// Collection of onboarding slides displayed
    /// during the application's introduction flow.
    @Published var slides: [OnboardingSlide] = [

        OnboardingSlide(
            imageName: "onboard1",
            title: "Manage your tasks",
            subtitle: "You can easily manage all of your daily tasks in UpTodo for free"
        ),

        OnboardingSlide(
            imageName: "onboard2",
            title: "Create daily routine",
            subtitle: "In UpTodo you can create your personalized routine to stay productive"
        ),

        OnboardingSlide(
            imageName: "onboard3",
            title: "Organize your tasks",
            subtitle: "You can organize your daily tasks by adding your tasks into separate categories"
        )
    ]

    // MARK: Navigation State

    /// Tracks the currently visible onboarding page.
    @Published var currentSlideIndex: Int = 0
}
