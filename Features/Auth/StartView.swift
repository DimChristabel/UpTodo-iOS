//
//  StartView.swift
//  upToDo
//
//  Created by Maxut Consulting on 26/05/2026.
//


import SwiftUI

struct StartView: View {

    @State private var showLogin = false
    @State private var showRegister = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack {
                    Spacer()

                    // Title
                    Text("Welcome to UpTodo")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    // Subtitle
                    Text("Please login to your account or create new account to continue")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.top, 20)

                    Spacer()

                    // Login Button
                    PrimaryButton(
                        title: "LOGIN",
                        cornerRadius: 6,
                        vertPadding: 18
                    ) {
                        showLogin = true
                    }
                    .padding(.horizontal, 24)

                    // Create Account Button
                    OutlineButton(
                        title: "CREATE ACCOUNT",
                        cornerRadius: 6,
                        vertPadding: 18
                    ) {
                        showRegister = true
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
            .navigationDestination(isPresented: $showLogin) {
                LoginView()
            }
            .navigationDestination(isPresented: $showRegister) {
                RegisterView()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    StartView()
}














//import SwiftUI
//
//struct StartView: View {
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.black.ignoresSafeArea()
//                
//                VStack(spacing: 0) {
//                    
//                    // ── Title ──
//                    Text("Welcome to UpTodo")
//                        .font(.system(size: 30, weight: .bold))
//                        .foregroundColor(.white)
//                        .frame(width: 291, height: 40)
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal, 42)
//                        .padding(.top, 139)
//                    
//                    // ── Subtitle ──
//                    Text("Please login to your account or create new account to continue")
//                        .font(.system(size: 13).weight(.regular))
//                        .foregroundColor(.white.opacity(0.8))
//                        .multilineTextAlignment(.center)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .padding(.horizontal, 40)
//                        .padding(.top, 203)
//                    
//                    Spacer()
//                    
//                    // ── LOGIN button ──
//                    NavigationLink(destination: LoginView()) {
//                        Text("LOGIN")
//                            .font(.system(size: 16, weight: .regular))
//                            .foregroundColor(.white)
//                            .frame(width: 50, height: 24)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 18)
//                            .background(Color("PurpleColor"))
//                            
//                    }
//                    .frame(width: 327, height: 48)
//                    .padding(.horizontal, 138)
//                    .padding(.vertical, 12)
//                    .padding(.top, 12)
//                    .cornerRadius(4)
//                   
//                    
//                    // ── CREATE ACCOUNT button ──
//                    NavigationLink(destination: RegisterView()) {
//                        Text("CREATE ACCOUNT")
//                            .font(.system(size: 16, weight: .regular))
//                            .foregroundColor(.white)
//                            .frame(width: 141, height: 24)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 18)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 6)
//                                    .stroke(Color("PurpleColor"),
//                                            lineWidth: 2)
//                            )
//                    }
//                    .frame(width: 327, height: 48)
//                    .padding(.horizontal, 24)
//                    .padding(.vertical, 12)
//                    .padding(.top, 12)
//                    .cornerRadius(4)
//                   
//                }
//                .frame(maxWidth: .infinity)
//            }
//           
//        }
//    }
//}
//
//#Preview {
//    StartView()
//}
//
//
