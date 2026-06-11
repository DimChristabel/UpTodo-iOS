//
//  ProfileSheets.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//

import Foundation

import SwiftUI

// MARK: - Change Name Sheet
struct ChangeNameSheet: View {
    @Binding var isPresented: Bool
    @State private var name = "Martha Hays"
    
    // ── Change title properties here ──
    private let titleText       = "Change account name"
    private let titleFontSize   : CGFloat = 16
    private let titleFontWeight = Font.Weight.semibold
    private let titleColor      = Color.white
    private let titleTopPad     : CGFloat = 24
    private let titleBotPad     : CGFloat = 20
    
    // ── Change field properties here ──
    private let fieldFontSize   : CGFloat = 15
    private let fieldBgColor    = Color.white.opacity(0.08)
    private let fieldCornerRad  : CGFloat = 4
    private let fieldHorizPad   : CGFloat = 24
    private let fieldBotPad     : CGFloat = 20
    
    // ── Change button properties here ──
    private let buttonCornerRad : CGFloat = 4
    private let buttonVertPad   : CGFloat = 14
    private let buttonHorizPad  : CGFloat = 24
    private let buttonBotPad    : CGFloat = 24
    private let buttonSpacing   : CGFloat = 12
    private let cancelBgColor   = Color.white.opacity(0.06)
    private let saveBgColor     = Color(red: 0.53,
                                        green: 0.46,
                                        blue: 1.0)
    var body: some View {
        VStack(spacing: 0) {
            
            // ── Title ──
            Text(titleText)
                .font(.system(size: titleFontSize,
                              weight: titleFontWeight))
                .foregroundColor(titleColor)
                .padding(.top, titleTopPad)
                .padding(.bottom, titleBotPad)
            
            // ── Name field ──
            TextField("", text: $name)
                .foregroundColor(.white)
                .font(.system(size: fieldFontSize))
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(fieldBgColor)
                .cornerRadius(fieldCornerRad)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: fieldCornerRad)
                        .stroke(Color.white.opacity(0.2),
                                lineWidth: 1)
                )
                .padding(.horizontal, fieldHorizPad)
                .padding(.bottom, fieldBotPad)
            
            // ── Cancel + Edit ──
            HStack(spacing: buttonSpacing) {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(saveBgColor)
                .font(.system(size: 15, weight: .medium))
                .frame(maxWidth: .infinity)
                .padding(.vertical, buttonVertPad)
                .background(cancelBgColor)
                .cornerRadius(buttonCornerRad)
                
                Button("Edit") {
                    isPresented = false
                }
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, buttonVertPad)
                .background(saveBgColor)
                .cornerRadius(buttonCornerRad)
            }
            .padding(.horizontal, buttonHorizPad)
            .padding(.bottom, buttonBotPad)
        }
    }
}

// MARK: - Change Password Sheet
struct ChangePasswordSheet: View {
    @Binding var isPresented: Bool
    @State private var oldPassword = ""
    @State private var newPassword = ""
    
    // ── Change title properties here ──
    private let titleText       = "Change account Password"
    private let titleFontSize   : CGFloat = 16
    private let titleFontWeight = Font.Weight.semibold
    private let titleColor      = Color.white
    private let titleTopPad     : CGFloat = 24
    private let titleBotPad     : CGFloat = 20
    
    // ── Change field properties here ──
    private let fieldFontSize   : CGFloat = 15
    private let fieldBgColor    = Color.white.opacity(0.08)
    private let fieldCornerRad  : CGFloat = 4
    private let fieldHorizPad   : CGFloat = 24
    private let fieldBotPad     : CGFloat = 16
    private let labelFontSize   : CGFloat = 13
    private let labelColor      = Color.white
    
    // ── Change button properties here ──
    private let buttonCornerRad : CGFloat = 4
    private let buttonVertPad   : CGFloat = 14
    private let buttonHorizPad  : CGFloat = 24
    private let buttonBotPad    : CGFloat = 24
    private let buttonSpacing   : CGFloat = 12
    private let cancelBgColor   = Color.white.opacity(0.06)
    private let saveBgColor     = Color(red: 0.53,
                                        green: 0.46,
                                        blue: 1.0)
    var body: some View {
        VStack(spacing: 0) {
            
            // ── Title ──
            Text(titleText)
                .font(.system(size: titleFontSize,
                              weight: titleFontWeight))
                .foregroundColor(titleColor)
                .padding(.top, titleTopPad)
                .padding(.bottom, titleBotPad)
            
            // ── Old password ──
            VStack(alignment: .leading, spacing: 8) {
                Text("Enter old password")
                    .font(.system(size: labelFontSize))
                    .foregroundColor(labelColor)
                SecureField("············",
                            text: $oldPassword)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(fieldBgColor)
                    .cornerRadius(fieldCornerRad)
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: fieldCornerRad)
                            .stroke(
                                Color.white.opacity(0.2),
                                lineWidth: 1)
                    )
            }
            .padding(.horizontal, fieldHorizPad)
            .padding(.bottom, fieldBotPad)
            
            // ── New password ──
            VStack(alignment: .leading, spacing: 8) {
                Text("Enter new password")
                    .font(.system(size: labelFontSize))
                    .foregroundColor(labelColor)
                SecureField("············",
                            text: $newPassword)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(fieldBgColor)
                    .cornerRadius(fieldCornerRad)
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: fieldCornerRad)
                            .stroke(
                                Color.white.opacity(0.2),
                                lineWidth: 1)
                    )
            }
            .padding(.horizontal, fieldHorizPad)
            .padding(.bottom, 20)
            
            // ── Cancel + Edit ──
            HStack(spacing: buttonSpacing) {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(saveBgColor)
                .font(.system(size: 15, weight: .medium))
                .frame(maxWidth: .infinity)
                .padding(.vertical, buttonVertPad)
                .background(cancelBgColor)
                .cornerRadius(buttonCornerRad)
                
                Button("Edit") {
                    isPresented = false
                }
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, buttonVertPad)
                .background(saveBgColor)
                .cornerRadius(buttonCornerRad)
            }
            .padding(.horizontal, buttonHorizPad)
            .padding(.bottom, buttonBotPad)
        }
    }
}

// MARK: - Change Image Sheet
struct ChangeImageSheet: View {
    @Binding var isPresented: Bool
    
    // ── Change title properties here ──
    private let titleText       = "Change account Image"
    private let titleFontSize   : CGFloat = 16
    private let titleFontWeight = Font.Weight.semibold
    private let titleColor      = Color.white
    private let titleTopPad     : CGFloat = 24
    private let titleBotPad     : CGFloat = 16
    
    // ── Change option properties here ──
    private let optionFontSize  : CGFloat = 15
    private let optionColor     = Color.white
    private let optionHorizPad  : CGFloat = 24
    private let optionVertPad   : CGFloat = 16
    
    var body: some View {
        VStack(spacing: 0) {
            
            // ── Title ──
            Text(titleText)
                .font(.system(size: titleFontSize,
                              weight: titleFontWeight))
                .foregroundColor(titleColor)
                .padding(.top, titleTopPad)
                .padding(.bottom, titleBotPad)
            
            Divider()
                .background(Color.white.opacity(0.15))
                .padding(.bottom, 8)
            
            // ── Options ──
            ImageOption(
                title: "Tack picture",
                fontSize: optionFontSize,
                textColor: optionColor,
                horizPad: optionHorizPad,
                vertPad: optionVertPad
            ) { isPresented = false }
            
            ImageOption(
                title: "Import from gallery",
                fontSize: optionFontSize,
                textColor: optionColor,
                horizPad: optionHorizPad,
                vertPad: optionVertPad
            ) { isPresented = false }
            
            ImageOption(
                title: "Import from Google Drive",
                fontSize: optionFontSize,
                textColor: optionColor,
                horizPad: optionHorizPad,
                vertPad: optionVertPad
            ) { isPresented = false }
            
            Spacer()
        }
    }
}

// MARK: - Image Option Row
struct ImageOption: View {
    let title    : String
    let fontSize : CGFloat
    let textColor: Color
    let horizPad : CGFloat
    let vertPad  : CGFloat
    let action   : () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: fontSize))
                    .foregroundColor(textColor)
                Spacer()
            }
            .padding(.horizontal, horizPad)
            .padding(.vertical, vertPad)
        }
    }
}







