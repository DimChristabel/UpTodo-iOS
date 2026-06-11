//
//  MainTabView.swift
//  upToDo
//
//  Created by Maxut Consulting on 09/06/2026.
//

import SwiftUI

// MARK: - MainTabView
// This is the root container that holds all 4 tabs

struct MainTabView: View {
    
    //  Tracks which tab is currently selected
    @State private var selectedTab = 0
    
    //  Controls Add Task sheet from + button
    @State private var showAddTask = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // ── Tab Content Area ──
            // Shows different screen based on selectedTab
            Group {
                switch selectedTab {
                case 0:
                    // Index/Home tab
                    HomeView()
                case 1:
                    // Calendar tab
                    CalendarView()
                case 2:
                    // Focus tab
                    FocusView()
                case 3:
                    // Profile tab
                    ProfileView()
                default:
                    HomeView()
                }
            }
            // Add bottom padding so content
            // doesn't hide behind tab bar
            .padding(.bottom, 60)
            
            // ── Custom Tab Bar ──
            VStack(spacing: 0) {
                Divider()
                    .background(Color.white.opacity(0.1))
                
                HStack(spacing: 0) {
                    
                    // ── Index Tab ──
                    TabBarItem(
                        icon: selectedTab == 0
                            ? "house.fill" : "house",
                        label: "Index",
                        isActive: selectedTab == 0
                    ) {
                        selectedTab = 0
                    }
                    
                    // ── Calendar Tab ──
                    TabBarItem(
                        icon: "calendar",
                        label: "Calendar",
                        isActive: selectedTab == 1
                    ) {
                        selectedTab = 1
                    }
                    
                    // ── Center space for + button ──
                    Spacer().frame(width: 60)
                    
                    // ── Focus Tab ──
                    TabBarItem(
                        icon: "clock",
                        label: "Focus",
                        isActive: selectedTab == 2
                    ) {
                        selectedTab = 2
                    }
                    
                    // ── Profile Tab ──
                    TabBarItem(
                        icon: selectedTab == 3
                            ? "person.fill" : "person",
                        label: "Profile",
                        isActive: selectedTab == 3
                    ) {
                        selectedTab = 3
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
                .background(Color.black)
            }
            
            // ── Floating + Button ──
            // Opens Add Task sheet from any tab
            Button {
                showAddTask = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 52, height: 52)
                    .background(Color(red: 0.53,
                                      green: 0.46,
                                      blue: 1.0))
                    .clipShape(Circle())
            }
            .padding(.bottom, 28)
        }
        .ignoresSafeArea(edges: .bottom)
        // ── Add Task Sheet ──
        .sheet(isPresented: $showAddTask) {
            AddTaskView()
                .presentationDetents([.height(320)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(16)
                .presentationBackground(
                    Color(red: 0.12,
                          green: 0.12,
                          blue: 0.12))
        }
    }
}

// MARK: - Tab Bar Item
// Each individual tab button
// Uses VStack so icon sits above label
struct TabBarItem: View {
    let icon    : String
    let label   : String
    let isActive: Bool
    let action  : () -> Void  // ← what happens when tapped
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(
                        isActive
                        ? Color(red: 0.53,
                                green: 0.46,
                                blue: 1.0)
                        : .gray)
                Text(label)
                    .font(.system(size: 10))
                    .foregroundColor(
                        isActive
                        ? Color(red: 0.53,
                                green: 0.46,
                                blue: 1.0)
                        : .gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    MainTabView()
}



