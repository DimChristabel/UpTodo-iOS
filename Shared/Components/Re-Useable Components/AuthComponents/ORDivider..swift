//
//  ORDivider..swift
//  upToDo
//
//  Created by Maxut Consulting on 15/06/2026.
//

import SwiftUI

// MARK: - ORDivider

/// A reusable divider component used to separate
/// authentication methods within the login and
/// registration flows.
///
/// Commonly displayed between traditional
/// credential-based authentication and
/// social authentication options.
struct ORDivider: View {

    // MARK: Body

    var body: some View {

        HStack {

            // MARK: Left Divider

            Rectangle()
                .fill(
                    Color.gray.opacity(0.3)
                )
                .frame(height: 1)

            // MARK: Divider Label

            Text("or")
                .foregroundColor(.gray)
                .padding(.horizontal)

            // MARK: Right Divider

            Rectangle()
                .fill(
                    Color.gray.opacity(0.3)
                )
                .frame(height: 1)
        }
    }
}

// MARK: - Preview

#Preview {

    ZStack {

        Color.black
            .ignoresSafeArea()

        ORDivider()
            .padding()
    }
    .preferredColorScheme(.dark)
}
