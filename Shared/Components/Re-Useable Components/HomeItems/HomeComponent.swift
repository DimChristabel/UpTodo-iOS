//
//  HomeComponent.swift
//  upToDo
//
//  Created by Maxut Consulting on 11/06/2026.
//

import SwiftUI

// MARK: - HomeSearchBar

/// A reusable search component used on the
/// Home screen for filtering tasks.
///
/// Allows users to search tasks by title
/// or description.
struct HomeSearchBar: View {

    // MARK: Properties

    @Binding var text: String

    var placeholder: String = "Search for your task..."
    var bgColor: Color = Color.white.opacity(0.07)

    var cornerRadius: CGFloat = 4
    var iconColor: Color = .gray
    var textColor: Color = .gray

    var fontSize: CGFloat = 16
    var height: CGFloat = 48
    var horizPad: CGFloat = 12

    // MARK: Body

    var body: some View {

        HStack {

            // MARK: Search Icon

            Image(systemName: "magnifyingglass")
                .foregroundColor(iconColor)
                .font(.system(size: fontSize))

            // MARK: Search Input

            TextField(
                placeholder,
                text: $text
            )
            .foregroundColor(textColor)
            .font(.system(size: fontSize))
        }
        .padding(.horizontal, horizPad)
        .frame(height: height)
        .background(bgColor)
        .cornerRadius(cornerRadius)

        // MARK: Border

        .overlay {

            RoundedRectangle(
                cornerRadius: cornerRadius
            )
            .stroke(
                Color.gray,
                lineWidth: 0.8
            )
        }
    }
}

// MARK: - TodayFilterChip

/// A reusable filter chip used to switch
/// between today's tasks and all tasks.
///
/// Displays the current filter state and
/// allows users to toggle it with a tap.
struct TodayFilterChip: View {

    // MARK: Properties

    @Binding var isActive: Bool

    var activeColor: Color = Color("MildPurple")
    var inactiveColor: Color = Color.gray

    var fontSize: CGFloat = 16
    var width: CGFloat = 110
    var height: CGFloat = 31

    var cornerRadius: CGFloat = 6

    // MARK: Body

    var body: some View {

        Button {

            isActive.toggle()

        } label: {

            HStack(spacing: 6) {

                Text("Today")
                    .font(
                        .system(
                            size: fontSize,
                            weight: .regular
                        )
                    )

                Image(
                    systemName:
                        isActive
                        ? "checkmark"
                        : "circle"
                )

                Image(systemName: "chevron.down")
            }
            .foregroundColor(.white)
            .frame(
                width: width,
                height: height
            )
            .background(
                isActive
                ? activeColor
                : inactiveColor
            )
            .cornerRadius(cornerRadius)
        }
    }
}

// MARK: - CompletedChip

/// Displays a label identifying the
/// completed tasks section.
///
/// Used as a visual section header
/// within the Home screen task list.
struct CompletedChip: View {

    // MARK: Properties

    var bgColor: Color = Color("MildPurple")

    var fontSize: CGFloat = 12
    var fontWeight: Font.Weight = .medium

    var textColor: Color = .white

    var horizPad: CGFloat = 10
    var vertPad: CGFloat = 5

    var cornerRadius: CGFloat = 4

    // MARK: Body

    var body: some View {

        HStack {

            HStack(spacing: 6) {

                Text("Completed")
                    .font(
                        .system(
                            size: fontSize,
                            weight: fontWeight
                        )
                    )
                    .foregroundColor(textColor)

                Image(systemName: "chevron.down")
                    .font(.system(size: fontSize))
                    .foregroundColor(textColor)
            }
            .padding(.horizontal, horizPad)
            .padding(.vertical, vertPad)
            .background(bgColor)
            .cornerRadius(cornerRadius)

            Spacer()
        }
    }
}

// MARK: - FABButton

/// Floating Action Button used throughout
/// the application for creating new tasks.
///
/// Provides quick access to the Add Task flow.
struct FABButton: View {

    // MARK: Properties

    /// Action executed when the button is tapped.
    let action: () -> Void

    // MARK: Body

    var body: some View {

        Button {

            action()

        } label: {

            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
                .frame(
                    width: 64,
                    height: 64
                )
                .background(
                    Color("MildPurple")
                )
                .clipShape(Circle())
        }
    }
}

// MARK: - Preview

#Preview {

    ZStack {

        Color.black
            .ignoresSafeArea()

        VStack(spacing: 16) {

            HomeSearchBar(
                text: .constant("")
            )
            .padding(.horizontal, 16)

            TodayFilterChip(
                isActive: .constant(true)
            )
            .padding(.horizontal, 16)

            CompletedChip()
                .padding(.horizontal, 16)

            FABButton {

                print("FAB tapped")
            }
            .padding(.bottom, 40)
        }
    }
    .preferredColorScheme(.dark)
}
