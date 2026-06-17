//
//  AppNavigationState.swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import Foundation

// MARK: - AppNavigationState

/// Defines the possible navigation flows
/// throughout the application.
enum AppNavigationState {

    // MARK: Launch Flow

    case intro
    case onboarding
    case welcome

    // MARK: Authentication Flow

    case login
    case register
    case fingerprint

    // MARK: Main Application Flow

    case dashboard
}
