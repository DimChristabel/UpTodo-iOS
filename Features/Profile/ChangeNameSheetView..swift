//
//  ChangeNameSheetView..swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - ChangeNameSheetView

/// Allows users to update their
/// account display name.
///
/// The updated name is validated
/// before being saved to Firestore.
///
/// Any successful update is
/// immediately reflected throughout
/// the application.
struct ChangeNameSheetView: View {

    // MARK: Environment

    @Environment(\.dismiss)
    private var dismiss

    // MARK: Properties

    @ObservedObject
    var viewModel: ProfileViewModel

    // MARK: Form State

    @State
    private var newName = ""

    // MARK: Body

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black
                    .ignoresSafeArea()

                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {

                    // MARK: Instructions

                    Text(
                        "Enter your new account name"
                    )
                    .foregroundColor(.gray)

                    // MARK: Name Input

                    TextField(
                        "Enter new name",
                        text: $newName
                    )
                    .padding()
                    .background(
                        Color.white.opacity(0.08)
                    )
                    .cornerRadius(12)
                    .foregroundColor(.white)

                    Spacer()
                }
                .padding()
            }

            // MARK: Navigation Title

            .navigationTitle(
                "Change Account Name"
            )
            .navigationBarTitleDisplayMode(
                .inline
            )

            // MARK: Navigation Controls

            .toolbar {

                ToolbarItem(
                    placement: .topBarLeading
                ) {

                    Button("Cancel") {

                        dismiss()
                    }
                    .foregroundColor(.gray)
                }

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Button("Save") {

                        saveName()
                    }
                    .foregroundColor(
                        Color("MildPurple")
                    )
                    .disabled(
                        newName
                            .trimmingCharacters(
                                in: .whitespacesAndNewlines
                            )
                            .isEmpty
                    )
                }
            }
        }

        // MARK: Initial Data Load

        .onAppear {

            newName =
            viewModel.currentUser?
                .displayName
            ?? viewModel.userName
        }
    }

    // MARK: Save Name

    /// Validates and updates the
    /// user's display name.
    private func saveName() {

        let cleanedName =
        newName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanedName.isEmpty
        else {
            return
        }

        viewModel.updateUserName(
            newName: cleanedName
        )

        dismiss()
    }
}

// MARK: - Preview

#Preview {

    ChangeNameSheetView(
        viewModel: ProfileViewModel()
    )
    .preferredColorScheme(.dark)
}
