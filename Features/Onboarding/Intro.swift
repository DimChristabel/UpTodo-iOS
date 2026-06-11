//
//  Intro.swift
//  upToDo
//
//  Created by Maxut Consulting on 26/05/2026.
//


import SwiftUI

struct Intro: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack {
                Spacer()

                Image("appLogo")
                    .resizable()
                    .frame(width: 140, height: 180)

                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    Intro()
}





