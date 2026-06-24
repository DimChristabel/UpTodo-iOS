//
//  BiometricSettingsView.swift
//  upToDo
//
//  Created by Maxut Consulting on 23/06/2026.
//


import SwiftUI

// MARK: - BiometricSettingsView

/// Allows users to enable or disable
/// biometric authentication for
/// future logins.
///
/// The preference is stored locally
/// using UserDefaults through the
/// BiometricManager.
struct BiometricSettingsView: View {

    // MARK: Properties

    @Environment(\.dismiss)
    private var dismiss

    @State private var isEnabled =
    BiometricManager.shared.isEnabled

    // MARK: Body

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black
                    .ignoresSafeArea()

                VStack(
                    alignment: .leading,
                    spacing: 24
                ) {

                    // MARK: Biometric Toggle

                    Toggle(
                        "Enable Face ID / Touch ID",
                        isOn: $isEnabled
                    )
                    .tint(
                        Color("MildPurple")
                    )
                    .foregroundColor(.white)

                    // MARK: Description

                    Text(
                        """
                        Enable biometric authentication for faster and more secure login.
                        """
                    )
                    .foregroundColor(.gray)

                    Spacer()
                }
                .padding()
            }

            // MARK: Navigation Title

            .navigationTitle(
                "Biometrics"
            )
            .navigationBarTitleDisplayMode(
                .inline
            )

            // MARK: Toolbar

            .toolbar {

                ToolbarItem(
                    placement: .topBarLeading
                ) {

                    Button("Cancel") {

                        dismiss()
                    }
                    .foregroundColor(
                        Color("MildPurple")
                    )
                }
            }
        }

        // MARK: Save Preference

        .onChange(
            of: isEnabled
        ) { _, newValue in

            BiometricManager.shared
                .setEnabled(newValue)
        }
    }
}

// MARK: - Preview

#Preview {

    BiometricSettingsView()
        .preferredColorScheme(.dark)
}
