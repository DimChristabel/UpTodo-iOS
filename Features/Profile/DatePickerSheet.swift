//
//  DatePickerSheet.swift
//  upToDo
//
//  Created by Maxut Consulting on 16/06/2026.
//

import SwiftUI

// MARK: - DatePickerSheet

/// Presents a calendar interface that allows users
/// to select a task due date.
///
/// Users can also navigate to the time picker sheet
/// to configure the task's due time.
struct DatePickerSheet: View {

    // MARK: Properties

    @Environment(\.dismiss)
    private var dismiss

    @Binding
    var selectedDate: Date

    @Binding
    var selectedTime: Date

    @State
    private var tempDate = Date()

    @State
    private var showTimePicker = false

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

                Text("Choose Date")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top)

                // MARK: Calendar Picker

                DatePicker(
                    "",
                    selection: $tempDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .labelsHidden()
                .colorScheme(.dark)
                .padding()

                Spacer()

                // MARK: Time Selection

                Button {

                    showTimePicker = true

                } label: {

                    Text("Choose Time")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            Color("MildPurple")
                        )
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)

                Divider()

                // MARK: Sheet Actions

                HStack {

                    Button("Cancel") {

                        dismiss()

                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)

                    Button("Save") {

                        selectedDate = tempDate
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

        // MARK: Time Picker Sheet

        .sheet(
            isPresented: $showTimePicker
        ) {

            TimePickerSheet(
                selectedTime: $selectedTime
            )
        }

        // MARK: Initial Data Load

        .onAppear {

            tempDate = selectedDate
        }
    }
}

// MARK: - Preview

#Preview {

    DatePickerSheet(
        selectedDate: .constant(Date()),
        selectedTime: .constant(Date())
    )
    .preferredColorScheme(.dark)
}
