//
//  FingerprintView.swift
//  upToDo
//
//  Created by Maxut Consulting on 31/05/2026.
//

import SwiftUI

// MARK: - FingerprintView
struct FingerprintView: View {

    // false = waiting
    // true = failed
    @State private var isFailed = false

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {

                Spacer()

                // Fingerprint Icon
                Image(systemName: "touchid")
                    .font(.system(size: 80))
                    .foregroundColor(
                        isFailed ? .red : .white
                    )
                    .padding(.bottom, 32)

                // Message
                Text(
                    isFailed
                    ? "Your fingerprint is not matched. Please try again later!!!"
                    : "Please hold your finger at the fingerprint scanner to verify your identity"
                )
                .font(.system(size: 20))
                .foregroundColor(
                    isFailed ? .red : .white
                )
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

                Spacer()

                // Bottom Buttons
                HStack(spacing: 12) {

                    TextButton(
                        title: "Cancel",
                        fontSize: 15,
                        fontWeight: .regular
                    ) {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)

                    PrimaryButton(
                        title: "Use Password",
                        fontSize: 15,
                        fontWeight: .regular
                    ) {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 60)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FingerprintView()
}

