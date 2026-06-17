//
//  TimePickerSheet.swift
//  upToDo
//
//  Created by Maxut Consulting on 16/06/2026.
//

import SwiftUI

// MARK: - TimePickerSheet

/// Presents a time selection interface used
/// during task creation and task editing.
///
/// The selected time is temporarily stored until
/// the user confirms their selection.
struct TimePickerSheet: View {

    // MARK: Properties

    @Environment(\.dismiss)
    private var dismiss

    @Binding
    var selectedTime: Date

    @State
    private var tempTime = Date()

    // MARK: Body

    var body: some View {

        ZStack {

            Color(
                red: 0.12,
                green: 0.12,
                blue: 0.12
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {

                // MARK: Sheet Title

                Text("Choose Time")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top)

                // MARK: Time Picker

                DatePicker(
                    "",
                    selection: $tempTime,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .colorScheme(.dark)

                Spacer()

                Divider()

                // MARK: Sheet Actions

                HStack {

                    Button {

                        dismiss()

                    } label: {

                        Text("Cancel")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                    }

                    Button {

                        selectedTime = tempTime
                        dismiss()

                    } label: {

                        Text("Save")
                            .foregroundColor(
                                Color("MildPurple")
                            )
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
            }
        }

        // MARK: Initial Data Load

        .onAppear {

            tempTime = selectedTime
        }
    }
}

// MARK: - Preview

#Preview {

    TimePickerSheet(
        selectedTime: .constant(Date())
    )
    .preferredColorScheme(.dark)
}
