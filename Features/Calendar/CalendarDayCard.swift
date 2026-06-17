//
//  CalendarDayCard.swift
//  upToDo
//
//  Created by Maxut Consulting on 16/06/2026.
//


import SwiftUI

// MARK: - CalendarDayCard

/// Represents a single day within the calendar week strip.
///
/// Displays the weekday, day number, and an optional
/// indicator showing whether tasks exist for that date.
struct CalendarDayCard: View {

    // MARK: Properties

    let date: Date

    @Binding
    var selectedDate: Date

    let hasTask: Bool

    private let calendar = Calendar.current

    // MARK: Computed Properties

    /// Determines whether the current day card
    /// matches the selected date.
    private var isSelected: Bool {

        calendar.isDate(
            date,
            inSameDayAs: selectedDate
        )
    }

    // MARK: Body

    var body: some View {

        Button {

            selectedDate = date

        } label: {

            VStack(spacing: 4) {

                // MARK: Weekday Label

                Text(
                    date.formatted(
                        .dateTime.weekday(.narrow)
                    )
                )
                .font(.caption2)
                .fontWeight(.medium)

                // MARK: Day Number

                Text(
                    date.formatted(
                        .dateTime.day()
                    )
                )
                .font(
                    .system(
                        size: 18,
                        weight: .semibold
                    )
                )

                // MARK: Task Indicator

                Circle()
                    .fill(
                        hasTask
                        ? Color.white
                        : Color.clear
                    )
                    .frame(
                        width: 5,
                        height: 5
                    )
            }

            .frame(
                width: 48,
                height: 72
            )

            .background(
                isSelected
                ? Color("MildPurple")
                : Color(
                    red: 0.14,
                    green: 0.14,
                    blue: 0.16
                )
            )

            .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {

    CalendarDayCard(
        date: Date(),
        selectedDate: .constant(Date()),
        hasTask: true
    )
    .preferredColorScheme(.dark)
}
