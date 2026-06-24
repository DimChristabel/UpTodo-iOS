//
//  BiometricSettingsView.swift
//  upToDo
//
//  Created by Maxut Consulting on 23/06/2026.
//

import Foundation

// MARK: - BiometricManager

/// Manages the user's biometric
/// authentication preference.
///
/// Stores whether biometric login
/// has been enabled by the user
/// using UserDefaults.
final class BiometricManager {

    // MARK: Singleton

    static let shared =
    BiometricManager()

    private init() {}

    // MARK: Properties

    private let biometricKey =
    "biometric_enabled"

    // MARK: Biometric Status

    /// Returns the current biometric
    /// authentication preference.
    var isEnabled: Bool {

        UserDefaults.standard.bool(
            forKey: biometricKey
        )
    }

    // MARK: Update Preference

    /// Saves the user's biometric
    /// authentication preference.
    func setEnabled(
        _ enabled: Bool
    ) {

        UserDefaults.standard.set(
            enabled,
            forKey: biometricKey
        )
    }
}
