//
//  SettingsView.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//

import Foundation

import SwiftUI

// MARK: - SettingsView
struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            //  Background 
            SettingsBackground()
            
            VStack(spacing: 0) {
                
                // Top Bar
                SettingsTopBar(onBack: { dismiss() })
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        //  Settings Section
                        SettingsSectionLabel(title: "Settings")
                        
                        SettingsRowItem(
                            icon: "paintbrush",
                            title: "Change app color"
                        ) { }
                        
                        SettingsRowItem(
                            icon: "textformat",
                            title: "Change app typography"
                        ) { }
                        
                        SettingsRowItem(
                            icon: "globe",
                            title: "Change app language"
                        ) { }
                        
                        // ── Import Section ──
                        SettingsSectionLabel(title: "Import")
                        
                        SettingsRowItem(
                            icon: "arrow.down.circle",
                            title: "Import from Google calendar"
                        ) { }
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Background
struct SettingsBackground: View {
    
    // ── Change background color here ──
    private let backgroundColor = Color.black
    
    var body: some View {
        backgroundColor.ignoresSafeArea()
    }
}

// MARK: - Top Bar
struct SettingsTopBar: View {
    let onBack: () -> Void
    
    // ── Change top bar properties here ──
    private let titleText      = "Settings"
    private let titleFontSize  : CGFloat = 18
    private let titleFontWeight = Font.Weight.semibold
    private let titleColor     = Color.white
    private let backIconSize   : CGFloat = 20
    private let backIconWeight = Font.Weight.medium
    private let backIconColor  = Color.white
    private let topPadding     : CGFloat = 20
    private let bottomPadding  : CGFloat = 16
    private let horizPadding   : CGFloat = 16
    
    var body: some View {
        ZStack {
            // Centered title
            Text(titleText)
                .font(.system(size: titleFontSize,
                              weight: titleFontWeight))
                .foregroundColor(titleColor)
            
            // Back button left
            HStack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: backIconSize,
                                      weight: backIconWeight))
                        .foregroundColor(backIconColor)
                }
                Spacer()
            }
            .padding(.horizontal, horizPadding)
        }
        .padding(.top, topPadding)
        .padding(.bottom, bottomPadding)
    }
}

// MARK: - Section Label
struct SettingsSectionLabel: View {
    let title: String
    
    // ── Change section label properties here ──
    private let fontSize      : CGFloat = 12
    private let textColor     = Color.gray
    private let topPadding    : CGFloat = 24
    private let bottomPadding : CGFloat = 8
    private let leftPadding   : CGFloat = 16
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(textColor)
                .padding(.horizontal, leftPadding)
                .padding(.top, topPadding)
                .padding(.bottom, bottomPadding)
            Spacer()
        }
    }
}

// MARK: - Settings Row Item
struct SettingsRowItem: View {
    let icon  : String
    let title : String
    let action: () -> Void
    
    // ── Change row properties here ──
    private let iconSize       : CGFloat = 20
    private let iconColor      = Color.white
    private let iconFrameWidth : CGFloat = 28
    private let titleFontSize  : CGFloat = 15
    private let titleColor     = Color.white
    private let chevronSize    : CGFloat = 13
    private let chevronColor   = Color.gray
    private let iconSpacing    : CGFloat = 14
    private let horizPadding   : CGFloat = 16
    private let vertPadding    : CGFloat = 18
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: iconSpacing) {
                Image(systemName: icon)
                    .font(.system(size: iconSize))
                    .foregroundColor(iconColor)
                    .frame(width: iconFrameWidth)
                Text(title)
                    .font(.system(size: titleFontSize))
                    .foregroundColor(titleColor)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: chevronSize))
                    .foregroundColor(chevronColor)
            }
            .padding(.horizontal, horizPadding)
            .padding(.vertical, vertPadding)
        }
    }
}

// MARK: - Preview
#Preview {
    SettingsView()
}
