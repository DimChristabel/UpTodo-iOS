//
//  ProfileComponents.swift
//  upToDo
//
//  Created by Maxut Consulting on 11/06/2026.
//

import SwiftUI

// MARK: - ProfileBadge

/// Displays a summary statistic within the
/// Profile screen.
///
/// Commonly used to show task counts such as
/// completed tasks and remaining tasks.
struct ProfileBadge: View {

    // MARK: Properties

    let title: String

    var bgColor: Color = Color.white.opacity(0.08)
    var cornerRadius: CGFloat = 4

    var fontSize: CGFloat = 13
    var fontWeight: Font.Weight = .medium

    var textColor: Color = .white
    var vertPad: CGFloat = 12

    // MARK: Body

    var body: some View {

        Text(title)
            .font(
                .system(
                    size: fontSize,
                    weight: fontWeight
                )
            )
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, vertPad)
            .background(bgColor)
            .cornerRadius(cornerRadius)
    }
}

// MARK: - ProfileSectionLabel

/// Displays a section title within the
/// Profile screen.
///
/// Used to separate groups of related
/// profile actions and settings.
struct ProfileSectionLabel: View {

    // MARK: Properties

    let title: String

    var fontSize: CGFloat = 12
    var textColor: Color = .gray

    var topPadding: CGFloat = 20
    var botPadding: CGFloat = 8
    var leftPadding: CGFloat = 24

    // MARK: Body

    var body: some View {

        HStack {

            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(textColor)
                .padding(.horizontal, leftPadding)
                .padding(.top, topPadding)
                .padding(.bottom, botPadding)

            Spacer()
        }
    }
}

// MARK: - ProfileRowItem

/// Displays a navigable profile menu item.
///
/// Consists of an icon, title, and navigation
/// indicator used throughout the Profile screen.
struct ProfileRowItem: View {

    // MARK: Properties

    let icon: String
    let title: String
    let action: () -> Void

    var iconSize: CGFloat = 18
    var iconColor: Color = .white
    var iconFrame: CGFloat = 24

    var titleSize: CGFloat = 15
    var titleColor: Color = .white

    var chevronSize: CGFloat = 13
    var chevronColor: Color = .gray

    var spacing: CGFloat = 14
    var horizPad: CGFloat = 24
    var vertPad: CGFloat = 14

    // MARK: Body

    var body: some View {

        Button(action: action) {

            HStack(spacing: spacing) {

                // MARK: Row Icon

                Image(systemName: icon)
                    .font(.system(size: iconSize))
                    .foregroundColor(iconColor)
                    .frame(width: iconFrame)

                // MARK: Row Title

                Text(title)
                    .font(.system(size: titleSize))
                    .foregroundColor(titleColor)

                Spacer()

                // MARK: Navigation Indicator

                Image(systemName: "chevron.right")
                    .font(.system(size: chevronSize))
                    .foregroundColor(chevronColor)
            }
            .padding(.horizontal, horizPad)
            .padding(.vertical, vertPad)
        }
    }
}

// MARK: - ProfileLogoutButton

/// Displays the logout action within
/// the Profile screen.
///
/// Styled differently from other profile
/// actions to emphasize its destructive nature.
struct ProfileLogoutButton: View {

    // MARK: Properties

    let action: () -> Void

    var iconName: String =
    "rectangle.portrait.and.arrow.right"

    var iconSize: CGFloat = 18
    var iconColor: Color = .red

    var textSize: CGFloat = 15
    var textWeight: Font.Weight = .medium
    var textColor: Color = .red

    var horizPad: CGFloat = 24
    var vertPad: CGFloat = 14
    var topPad: CGFloat = 8

    // MARK: Body

    var body: some View {

        Button(action: action) {

            HStack(spacing: 12) {

                // MARK: Logout Icon

                Image(systemName: iconName)
                    .font(.system(size: iconSize))
                    .foregroundColor(iconColor)

                // MARK: Logout Label

                Text("Log out")
                    .font(
                        .system(
                            size: textSize,
                            weight: textWeight
                        )
                    )
                    .foregroundColor(textColor)

                Spacer()
            }
            .padding(.horizontal, horizPad)
            .padding(.vertical, vertPad)
        }
        .padding(.top, topPad)
    }
}

// MARK: - SettingsRowItem

/// Displays a settings option row.
///
/// Used within Settings screens to present
/// configurable application options.
struct SettingsRowItem: View {

    // MARK: Properties

    let icon: String
    let title: String
    let action: () -> Void

    var iconSize: CGFloat = 20
    var iconColor: Color = .white
    var iconFrame: CGFloat = 28

    var titleSize: CGFloat = 15
    var titleColor: Color = .white

    var chevronSize: CGFloat = 13
    var chevronColor: Color = .gray

    var spacing: CGFloat = 14
    var horizPad: CGFloat = 16
    var vertPad: CGFloat = 18

    // MARK: Body

    var body: some View {

        Button(action: action) {

            HStack(spacing: spacing) {

                // MARK: Settings Icon

                Image(systemName: icon)
                    .font(.system(size: iconSize))
                    .foregroundColor(iconColor)
                    .frame(width: iconFrame)

                // MARK: Settings Title

                Text(title)
                    .font(.system(size: titleSize))
                    .foregroundColor(titleColor)

                Spacer()

                // MARK: Navigation Indicator

                Image(systemName: "chevron.right")
                    .font(.system(size: chevronSize))
                    .foregroundColor(chevronColor)
            }
            .padding(.horizontal, horizPad)
            .padding(.vertical, vertPad)
        }
    }
}

// MARK: - Preview

#Preview {

    ZStack {

        Color.black
            .ignoresSafeArea()

        VStack(spacing: 0) {

            HStack(spacing: 12) {

                ProfileBadge(
                    title: "10 Task left"
                )

                ProfileBadge(
                    title: "5 Task done"
                )
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)

            ProfileSectionLabel(
                title: "Settings"
            )

            ProfileRowItem(
                icon: "gearshape",
                title: "App Settings"
            ) { }

            ProfileSectionLabel(
                title: "Account"
            )

            ProfileRowItem(
                icon: "person",
                title: "Change account name"
            ) { }

            ProfileLogoutButton {

            }
        }
    }
    .preferredColorScheme(.dark)
}
