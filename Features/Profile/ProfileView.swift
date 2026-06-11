//
//  ProfileView.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//

import SwiftUI

// MARK: - ProfileView
struct ProfileView: View {
    
    // ── Sheet states ──
    @State private var showChangeName     = false
    @State private var showChangePassword = false
    @State private var showChangeImage    = false
    @State private var showSettings       = false
    
    // ── User data ──
    private let userName  = "Martha Hays"
    private let tasksLeft = 10
    private let tasksDone = 5
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                // ── Background ──
                Color.black.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        // ── Title ──
                        Text("Profile")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .padding(.bottom, 24)
                        
                        // ── Avatar ──
                        Image("profileImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 85, height: 85)
                            .clipShape(Circle())
                            .padding(.bottom, 20)
                        
                        // ── Name ──
                        Text(userName)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        
                        // ── Task badges ──
                        // ProfileBadge lives in ProfileComponents.swift
                        HStack(spacing: 12) {
                            ProfileBadge(
                                title: "\(tasksLeft) Task left")
                            ProfileBadge(
                                title: "\(tasksDone) Task done")
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 32)
                        
                        // ── Settings section ──
                        // ProfileSectionLabel lives in ProfileComponents.swift
                        ProfileSectionLabel(title: "Settings")
                        // ProfileRowItem lives in ProfileComponents.swift
                        ProfileRowItem(
                            icon: "gearshape",
                            title: "App Settings"
                        ) { showSettings = true }
                        
                        // ── Account section ──
                        ProfileSectionLabel(title: "Account")
                        ProfileRowItem(
                            icon: "person",
                            title: "Change account name"
                        ) { showChangeName = true }
                        ProfileRowItem(
                            icon: "lock",
                            title: "Change account password"
                        ) { showChangePassword = true }
                        ProfileRowItem(
                            icon: "camera",
                            title: "Change account Image"
                        ) { showChangeImage = true }
                        
                        // ── Uptodo section ──
                        ProfileSectionLabel(title: "Uptodo")
                        ProfileRowItem(
                            icon: "square.grid.2x2",
                            title: "About US"
                        ) { }
                        ProfileRowItem(
                            icon: "info.circle",
                            title: "FAQ"
                        ) { }
                        ProfileRowItem(
                            icon: "bolt",
                            title: "Help & Feedback"
                        ) { }
                        ProfileRowItem(
                            icon: "hand.thumbsup",
                            title: "Support US"
                        ) { }
                        
                        // ── Log out ──
                        // ProfileLogoutButton lives in ProfileComponents.swift
                        ProfileLogoutButton(action: { })
                        
                        // Space for tab bar
                        Spacer().frame(height: 100)
                    }
                }
                
                // ── Floating + button ──
                // FABButton lives in AppButtons.swift
                FABButton {
                    // FAB action — can open add task
                }
                .padding(.bottom, 28)
            }
            // ── Sheets ──
            .sheet(isPresented: $showChangeName) {
                ChangeNameSheet(isPresented: $showChangeName)
                    .presentationDetents([.height(220)])
                    .presentationCornerRadius(16)
                    .presentationBackground(
                        Color(red: 0.15,
                              green: 0.15,
                              blue: 0.15))
            }
            .sheet(isPresented: $showChangePassword) {
                ChangePasswordSheet(isPresented: $showChangePassword)
                    .presentationDetents([.height(320)])
                    .presentationCornerRadius(16)
                    .presentationBackground(
                        Color(red: 0.15,
                              green: 0.15,
                              blue: 0.15))
            }
            .sheet(isPresented: $showChangeImage) {
                ChangeImageSheet(isPresented: $showChangeImage)
                    .presentationDetents([.height(220)])
                    .presentationCornerRadius(16)
                    .presentationBackground(
                        Color(red: 0.15,
                              green: 0.15,
                              blue: 0.15))
            }
            // ── Settings Navigation ──
            .navigationDestination(isPresented: $showSettings) {
                SettingsView()
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Dummy Subviews (For Preview Compilation Safety)
// These keep your project compiling if the individual sheet files aren't in your target scope yet.
//struct ChangeNameSheet: View { @Binding var isPresented: Bool; var body: some View { Text("Change Name").foregroundColor(.white) } }
//struct ChangePasswordSheet: View { @Binding var isPresented: Bool; var body: some View { Text("Change Password").foregroundColor(.white) } }
//struct ChangeImageSheet: View { @Binding var isPresented: Bool; var body: some View { Text("Change Image").foregroundColor(.white) } }
//struct SettingsView: View { var body: some View { Text("Settings Screen").foregroundColor(.white).frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black) } }

// MARK: - Preview
#Preview {
    ProfileView()
}
