//
//  OnboardingComponents.swift
//  upToDo
//
//  Created by Maxut Consulting on 11/06/2026.
//

import SwiftUI

// MARK: - Onboarding Dot Indicator
// The 3 dashes showing which slide is active
// Used in: OnboardingView
struct OnboardingDots: View {
    let currentPage : Int
    let totalPages  : Int
    var activeColor : Color   = .white
    var inactiveColor: Color  = Color.gray.opacity(0.5)
    var activeWidth : CGFloat = 28
    var inactiveWidth: CGFloat = 20
    var height      : CGFloat = 4
    var spacing     : CGFloat = 6
    var cornerRadius: CGFloat = 3
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<totalPages, id: \.self) { index in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(index == currentPage
                          ? activeColor
                          : inactiveColor)
                    .frame(
                        width: index == currentPage
                        ? activeWidth
                        : inactiveWidth,
                        height: height)
                    .animation(.easeInOut,
                               value: currentPage)
            }
        }
    }
}

// MARK: - Onboarding Slide Title
// Large bold title on each slide
// Used in: OnboardingView
struct OnboardingTitle: View {
    let title     : String
    var fontSize  : CGFloat     = 28
    var fontWeight: Font.Weight = .bold
    var textColor : Color       = .white
    var alignment : TextAlignment = .center
    var width     : CGFloat     = 269
    var height    : CGFloat     = 38
    var botPadding: CGFloat     = 20
    
    var body: some View {
        Text(title)
            .font(.system(size: fontSize,
                          weight: fontWeight))
            .foregroundColor(textColor)
            .frame(width: width, height: height)
            .multilineTextAlignment(alignment)
            .padding(.bottom, botPadding)
    }
}

// MARK: - Onboarding Subtitle
// Smaller grey body text on each slide
// Used in: OnboardingView
struct OnboardingSubtitle: View {
    let text      : String
    var fontSize  : CGFloat     = 15
    var fontWeight: Font.Weight = .regular
    var textColor : Color       = .gray
    var alignment : TextAlignment = .center
    var width     : CGFloat     = 299
    var height    : CGFloat     = 48
    var botPadding: CGFloat     = 20
    
    var body: some View {
        Text(text)
            .font(.system(size: fontSize,
                          weight: fontWeight))
            .foregroundColor(textColor)
            .frame(width: width, height: height)
            .multilineTextAlignment(alignment)
            .padding(.bottom, botPadding)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 20) {
            OnboardingDots(currentPage: 0, totalPages: 3)
            OnboardingTitle(title: "Manage your tasks")
            OnboardingSubtitle(
                text: "You can easily manage all of your daily tasks")
        }
    }
}







