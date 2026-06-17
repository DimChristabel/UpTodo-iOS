//
//  ChangeNameSheetView..swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - ChangeNameSheetView

/// Allows users to update their account display name.
///
/// The updated name is validated before being
/// saved through the TaskViewModel.
struct ChangeNameSheetView: View {

    // MARK: Properties

    @Environment(\.dismiss)
    private var dismiss

    @ObservedObject
    var viewModel: TaskViewModel

    @State private var newName = ""

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

                    Text("Enter your new account name")
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
            .navigationTitle("Change Account Name")
            .navigationBarTitleDisplayMode(.inline)

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

                        viewModel.changeUserName(
                            newName
                        )

                        dismiss()
                    }
                    .foregroundColor(
                        Color("MildPurple")
                    )
                    .disabled(
                        newName.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
                }
            }
        }

        // MARK: Initial Data Load

        .onAppear {

            newName = viewModel.userName
        }
    }
}

// MARK: - Preview

#Preview {

    ChangeNameSheetView(
        viewModel: TaskViewModel()
    )
    .preferredColorScheme(.dark)
}
