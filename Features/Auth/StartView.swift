//
//  StartView.swift
//  upToDo
//
//  Created by Maxut Consulting on 26/05/2026.
//

import SwiftUI

// MARK: - StartView
struct StartView: View {
    
    // ── Navigation states ──
    @State private var showLogin    = false
    @State private var showRegister = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // ── Background ──
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    // ── Back button ──
                    // IconButton from AppButtons.swift
                    HStack {
                        IconButton(
                            iconName: "chevron.left",
                            iconSize: 20,
                            iconWeight: .medium,
                            iconColor: .white,
                            frameSize: 24
                        ) {
                            // goes back to onboarding
                            // only shows if NavigationStack has history
                        }
                        .padding(.leading, 16)
                        .padding(.top, 20)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    // ── Title ──
                    Text("Welcome to UpTodo")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    // ── Subtitle ──
                    Text("Please login to your account or create new account to continue")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    // ── LOGIN button ──
                    // PrimaryButton from AppButtons.swift
                    PrimaryButton(
                        title: "LOGIN",
                        fontSize: 16,
                        fontWeight: .bold,
                        textColor: .white,
                        bgColor: Color(red: 0.53,
                                      green: 0.46,
                                      blue: 1.0),
                        cornerRadius: 6,
                        vertPadding: 18
                    ) {
                        showLogin = true
                    }
                    .padding(.horizontal, 24)
                    
                    // ── CREATE ACCOUNT button ──
                    // OutlineButton from AppButtons.swift
                    OutlineButton(
                        title: "CREATE ACCOUNT",
                        fontSize: 16,
                        fontWeight: .bold,
                        textColor: .white,
                        borderColor: Color(red: 0.53,
                                           green: 0.46,
                                           blue: 1.0),
                        borderWidth: 1.5,
                        cornerRadius: 6,
                        vertPadding: 18
                    ) {
                        showRegister = true
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 48)
                }
            }
            // ── Navigation destinations ──
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
