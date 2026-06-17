//
//  PriorityPickerView.swift
//  upToDo
//
//  Created by Maxut Consulting on 16/06/2026.
//

import SwiftUI

// MARK: - PriorityPickerView

/// Allows users to select a priority level
/// for a task.
///
/// Priority values range from 1 to 10, with
/// higher values representing higher priority.
struct PriorityPickerView: View {

    // MARK: Properties

    @Environment(\.dismiss)
    private var dismiss

    @Binding
    var selectedPriority: Int

    @State
    private var tempPriority: Int = 1

    /// Grid layout used to display
    /// priority selection buttons.
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack {

                // MARK: Header

                Text("Task Priority")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top)

                // MARK: Priority Grid

                LazyVGrid(
                    columns: columns,
                    spacing: 16
                ) {

                    ForEach(1...10, id: \.self) { value in

                        Button {

                            tempPriority = value

                        } label: {

                            VStack {

                                Image(systemName: "flag.fill")

                                Text("\(value)")
                            }
                            .foregroundColor(.white)
                            .frame(
                                maxWidth: .infinity,
                                minHeight: 70
                            )
                            .background(
                                tempPriority == value
                                ? Color("MildPurple")
                                : Color.white.opacity(0.08)
                            )
                            .cornerRadius(12)
                        }
                    }
                }
                .padding()

                Spacer()

                Divider()

                // MARK: Sheet Actions

                HStack {

                    Button("Cancel") {

                        dismiss()
                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)

                    Button("Save") {

                        selectedPriority = tempPriority
                        dismiss()
                    }
                    .foregroundColor(
                        Color("MildPurple")
                    )
                    .frame(maxWidth: .infinity)
                }
                .padding()
            }
        }

        // MARK: Initial Data Load

        .onAppear {

            tempPriority = selectedPriority
        }
    }
}

// MARK: - Preview

#Preview {

    PriorityPickerView(
        selectedPriority: .constant(5)
    )
    .preferredColorScheme(.dark)
}
