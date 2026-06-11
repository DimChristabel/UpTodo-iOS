//
//  AuthComponents.swift
//  upToDo
//
//  Created by Maxut Consulting on 11/06/2026.
//

import SwiftUI

// MARK: - Field Label
// Grey label above each input field
// Used in: LoginView, RegisterView
struct FieldLabel: View {
    let title     : String
    var fontSize  : CGFloat     = 13
    var fontWeight: Font.Weight = .medium
    var textColor : Color       = .white
    var botPadding: CGFloat     = 8
    
    var body: some View {
        Text(title)
            .font(.system(size: fontSize,
                          weight: fontWeight))
            .foregroundColor(textColor)
            .padding(.bottom, botPadding)
    }
}

// MARK: - Input Field
// Standard text input field
// Used in: LoginView username, RegisterView username
struct InputField: View {
    let placeholder: String
    @Binding var text: String
    var fontSize   : CGFloat = 15
    var bgColor    : Color   = Color.white.opacity(0.07)
    var cornerRad  : CGFloat = 4
    var borderColor: Color   = Color.white.opacity(0.15)
    var horizPad   : CGFloat = 16
    var vertPad    : CGFloat = 14
    
    var body: some View {
        TextField(placeholder, text: $text)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .foregroundColor(.white)
            .font(.system(size: fontSize))
            .padding(.horizontal, horizPad)
            .padding(.vertical, vertPad)
            .background(bgColor)
            .cornerRadius(cornerRad)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRad)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}

// MARK: - Secure Input Field
// Password input field — hides characters
// Used in: LoginView password, RegisterView password
struct SecureInputField: View {
    let placeholder: String
    @Binding var text: String
    var fontSize   : CGFloat = 15
    var bgColor    : Color   = Color.white.opacity(0.07)
    var cornerRad  : CGFloat = 4
    var borderColor: Color   = Color.white.opacity(0.15)
    var horizPad   : CGFloat = 16
    var vertPad    : CGFloat = 14
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .foregroundColor(.white)
            .font(.system(size: fontSize))
            .padding(.horizontal, horizPad)
            .padding(.vertical, vertPad)
            .background(bgColor)
            .cornerRadius(cornerRad)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRad)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}

// MARK: - OR Divider
// Horizontal line with "or" text in middle
// Used in: LoginView, RegisterView
struct ORDivider: View {
    var lineColor : Color   = Color.white.opacity(0.15)
    var textColor : Color   = Color.gray
    var fontSize  : CGFloat = 13
    var horizPad  : CGFloat = 12
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(lineColor)
                .frame(height: 1)
            Text("or")
                .font(.system(size: fontSize))
                .foregroundColor(textColor)
                .padding(.horizontal, horizPad)
            Rectangle()
                .fill(lineColor)
                .frame(height: 1)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 16) {
            FieldLabel(title: "Username")
            InputField(
                placeholder: "Enter your username",
                text: .constant(""))
            FieldLabel(title: "Password")
            SecureInputField(
                placeholder: "············",
                text: .constant(""))
            ORDivider()
        }
        .padding(.horizontal, 24)
    }
}




