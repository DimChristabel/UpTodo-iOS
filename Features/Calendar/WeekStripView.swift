//
//  WeekStripView.swift
//  upToDo
//
//  Created by Maxut Consulting on 16/06/2026.
//

import SwiftUI

// MARK: - WeekStripView

/// Displays the current week's dates in a
/// horizontal calendar strip.
///
/// Allows users to select a specific day and
/// updates the bound selected date accordingly.
struct WeekStripView: View {

    // MARK: Properties

    @Binding var selectedDate: Date

    private let calendar = Calendar.current

    // MARK: Body

    var body: some View {

        HStack {

            ForEach(currentWeek(), id: \.self) { date in

                Button {

                    selectedDate = date

                } label: {

                    VStack(spacing: 6) {

                        Text(weekday(date))

                        Text("\(calendar.component(.day, from: date))")
                    }
                    .frame(width: 44, height: 60)
                    .background(
                        calendar.isDate(
                            selectedDate,
                            inSameDayAs: date
                        )
                        ? Color("MildPurple")
                        : Color.white.opacity(0.08)
                    )
                    .cornerRadius(8)
                }
            }
        }
        .padding()
    }

    // MARK: Date Helpers

    /// Returns all dates within the current week.
    private func currentWeek() -> [Date] {

        guard let weekInterval =
            calendar.dateInterval(
                of: .weekOfYear,
                for: Date()
            )
        else {
            return []
        }

        return (0..<7).compactMap {

            calendar.date(
                byAdding: .day,
                value: $0,
                to: weekInterval.start
            )
        }
    }

    /// Returns a short weekday abbreviation
    /// for the supplied date.
    private func weekday(_ date: Date) -> String {

        let formatter = DateFormatter()

        formatter.dateFormat = "EEE"

        return formatter.string(from: date)
    }
}

// MARK: - Preview

#Preview {

    WeekStripView(
        selectedDate: .constant(Date())
    )
    .preferredColorScheme(.dark)
}
