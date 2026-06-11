//
//  AppButtons.swift
//  upToDo
//
//  Created by Maxut Consulting on 11/06/2026.
//

import SwiftUI

// MARK: - Primary Button
// Purple filled button
// Used in: Login, Register, Onboarding, AddTask
struct PrimaryButton: View {
    let title       : String
    var fontSize    : CGFloat     = 16
    var fontWeight  : Font.Weight = .bold
    var textColor   : Color       = .white
    var bgColor     : Color       = Color("MildPurple")
    var cornerRadius: CGFloat     = 4
    var vertPadding : CGFloat     = 16
    let action      : () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize,
                              weight: fontWeight))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, vertPadding)
                .background(bgColor)
                .cornerRadius(cornerRadius)
        }
    }
}


// MARK: - Outline Button
// Used in: StartView Create Account button
struct OutlineButton: View {
    let title       : String
    var fontSize    : CGFloat     = 16
    var fontWeight  : Font.Weight = .bold
    var textColor   : Color       = .white
    var borderColor : Color       = Color("MildPurple")
    var borderWidth : CGFloat     = 1.5
    var cornerRadius: CGFloat     = 4
    var vertPadding : CGFloat     = 16
    let action      : () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize,
                              weight: fontWeight))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, vertPadding)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor,
                                lineWidth: borderWidth)
                )
        }
    }
}


// MARK: - Text Button
// Plain text no background
// Used in: SKIP, BACK, Forgot Password
struct TextButton: View {
    let title     : String
    var fontSize  : CGFloat     = 14
    var fontWeight: Font.Weight = .regular
    var textColor : Color       = .white
    let action    : () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize,
                              weight: fontWeight))
                .foregroundColor(textColor)
        }
    }
}


// MARK: - Icon Button
// Icon only no text
// Used in: Back arrow, hamburger menu
struct IconButton: View {
    let iconName  : String
    var iconSize  : CGFloat     = 20
    var iconWeight: Font.Weight = .medium
    var iconColor : Color       = .white
    var frameSize : CGFloat     = 44
    let action    : () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.system(size: iconSize,
                              weight: iconWeight))
                .foregroundColor(iconColor)
                .frame(width: frameSize,
                       height: frameSize)
        }
    }
}


// MARK: - FAB Button
// Floating purple + button
// Used in: HomeView, MainTabView
struct FABButton: View {
    var iconName  : String      = "plus"
    var iconSize  : CGFloat     = 22
    var iconWeight: Font.Weight = .bold
    var iconColor : Color       = .white
    var bgColor   : Color       = Color("MildPurple")
    var size      : CGFloat     = 52
    let action    : () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.system(size: iconSize,
                              weight: iconWeight))
                .foregroundColor(iconColor)
                .frame(width: size, height: size)
                .background(bgColor)
                .clipShape(Circle())
        }
    }
}


// MARK: - Sheet Action Button
// Used inside bottom sheets
// Used in: ChangeNameSheet, ChangePasswordSheet
struct SheetActionButton: View {
    let title       : String
    var fontSize    : CGFloat     = 15
    var fontWeight  : Font.Weight = .bold
    var textColor   : Color       = .white
    var bgColor     : Color       = Color("MildPurple")
    var cornerRadius: CGFloat     = 4
    var vertPadding : CGFloat     = 14
    let action      : () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize,
                              weight: fontWeight))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, vertPadding)
                .background(bgColor)
                .cornerRadius(cornerRadius)
        }
    }
}


// MARK: - Social Auth Button
// Icon + text button
// Used in: LoginView, RegisterView
struct SocialAuthButton: View {
    let title       : String
    var systemIcon  : String?     = nil
    var assetIcon   : String?     = nil
    var fontSize    : CGFloat     = 15
    var fontWeight  : Font.Weight = .medium
    var textColor   : Color       = .white
    var borderColor : Color       = Color.white.opacity(0.3)
    var borderWidth : CGFloat     = 1
    var cornerRadius: CGFloat     = 4
    var vertPadding : CGFloat     = 14
    var iconSize    : CGFloat     = 20
    let action      : () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let system = systemIcon {
                    Image(systemName: system)
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize,
                               height: iconSize)
                        .foregroundColor(textColor)
                } else if let asset = assetIcon {
                    Image(asset)
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize,
                               height: iconSize)
                }
                Text(title)
                    .font(.system(size: fontSize,
                                  weight: fontWeight))
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, vertPadding)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor,
                            lineWidth: borderWidth)
            )
        }
    }
}



//Previews
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 16) {
            PrimaryButton(title: "Login") { }
                .padding(.horizontal, 24)
            OutlineButton(title: "Create Account") { }
                .padding(.horizontal, 24)
            TextButton(title: "SKIP") { }
            IconButton(iconName: "chevron.left") { }
            SocialAuthButton(
                title: "Login with Google",
                assetIcon: "google_icon") { }
                .padding(.horizontal, 24)
            FABButton { }
            HStack(spacing: 12) {
                SheetActionButton(
                    title: "Cancel",
                    bgColor: Color.white.opacity(0.06)
                ) { }
                SheetActionButton(title: "Edit") { }
            }
            .padding(.horizontal, 24)
        }
    }
}





