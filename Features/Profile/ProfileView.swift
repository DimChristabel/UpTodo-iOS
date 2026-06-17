//
//  ProfileView.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//

import SwiftUI

// MARK: - ProfileView

/// Displays the user's profile information,
/// account settings, productivity statistics,
/// and application-related options.
///
/// This screen also manages profile image updates,
/// account management actions, and navigation to
/// supporting informational screens.
struct ProfileView: View {

    // MARK: Properties

    @ObservedObject
    var viewModel: TaskViewModel

    // MARK: Sheet States

    @State private var showSettings = false
    @State private var showAboutUs = false
    @State private var showFAQ = false
    @State private var showImagePicker = false
    @State private var showCamera = false

    @State private var showImageOptions = false
    @State private var showHelpAndFeedback = false
    @State private var showSupportUs = false

    // MARK: Image Selection

    @State private var selectedImage: UIImage?

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: Header

                Text("Profile")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.top, 12)
                    .padding(.bottom, 24)

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 0) {

                        // MARK: User Profile

                        VStack(spacing: 12) {

                            Group {

                                if let image = viewModel.profileUIImage {

                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()

                                } else {

                                    Image("profileImage")
                                        .resizable()
                                        .scaledToFill()
                                }
                            }
                            .frame(
                                width: 90,
                                height: 90
                            )
                            .clipShape(Circle())

                            Text(viewModel.userName)
                                .font(
                                    .system(
                                        size: 20,
                                        weight: .medium
                                    )
                                )
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 30)

                        // MARK: Productivity Statistics

                        HStack(spacing: 16) {

                            ProfileBadge(
                                title: "\(viewModel.incompleteTasksCount) Task left"
                            )

                            ProfileBadge(
                                title: "\(viewModel.completedTasksCount) Task done"
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)

                        // MARK: Settings Section

                        ProfileSectionLabel(
                            title: "Settings"
                        )

                        ProfileRowItem(
                            icon: "gearshape",
                            title: "App Settings"
                        ) {

                            showSettings = true
                        }

                        ProfileRowItem(
                            icon: "bubble.left.and.bubble.right",
                            title: "Help & Feedback"
                        ) {

                            showHelpAndFeedback = true
                        }

                        ProfileRowItem(
                            icon: "heart",
                            title: "Support Us"
                        ) {

                            showSupportUs = true
                        }

                        // MARK: Account Section

                        ProfileSectionLabel(
                            title: "Account"
                        )

                        ProfileRowItem(
                            icon: "person",
                            title: "Change account name"
                        ) {

                            viewModel.showChangeNameSheet = true
                        }

                        ProfileRowItem(
                            icon: "key",
                            title: "Change password"
                        ) {

                            viewModel.showChangePasswordSheet = true
                        }

                        ProfileRowItem(
                            icon: "camera",
                            title: "Change image"
                        ) {

                            showImageOptions = true
                        }

                        // MARK: Application Information

                        ProfileSectionLabel(
                            title: "UpTodo"
                        )

                        ProfileRowItem(
                            icon: "info.circle",
                            title: "About Us"
                        ) {

                            showAboutUs = true
                        }

                        ProfileRowItem(
                            icon: "questionmark.circle",
                            title: "FAQ"
                        ) {

                            showFAQ = true
                        }

                        // MARK: Logout

                        ProfileLogoutButton {

                            viewModel.logout()
                        }
                        .padding(.top, 12)
                    }
                    .padding(.bottom, 40)
                }
            }
        }

        // MARK: Profile Image Observer

        .onChange(
            of: selectedImage
        ) { _, newImage in

            guard let image = newImage else {
                return
            }

            viewModel.saveProfileImage(image)
        }

        // MARK: Image Source Selection

        .confirmationDialog(
            "Change Profile Image",
            isPresented: $showImageOptions
        ) {

            Button("Take Photo") {

                showCamera = true
            }

            Button("Import from Gallery") {

                showImagePicker = true
            }

            Button("Import from Google Drive") {

                // Future Firebase Storage / Drive Integration
            }

            Button(
                "Cancel",
                role: .cancel
            ) { }
        }

        // MARK: Settings Sheet

        .sheet(
            isPresented: $showSettings
        ) {

            SettingsView()
        }

        // MARK: Change Name Sheet

        .sheet(
            isPresented: $viewModel.showChangeNameSheet
        ) {

            ChangeNameSheetView(
                viewModel: viewModel
            )
        }

        // MARK: Change Password Sheet

        .sheet(
            isPresented: $viewModel.showChangePasswordSheet
        ) {

            ChangePasswordSheetView(
                viewModel: viewModel
            )
        }

        // MARK: About Us Sheet

        .sheet(
            isPresented: $showAboutUs
        ) {

            AboutUsView()
        }

        // MARK: FAQ Sheet

        .sheet(
            isPresented: $showFAQ
        ) {

            FAQView()
        }

        // MARK: Help & Feedback Sheet

        .sheet(
            isPresented: $showHelpAndFeedback
        ) {

            HelpAndFeedbackView()
        }

        // MARK: Support Us Sheet

        .sheet(
            isPresented: $showSupportUs
        ) {

            SupportUsView()
        }

        // MARK: Image Picker Sheet

        .sheet(
            isPresented: $showImagePicker
        ) {

            ImagePicker(
                selectedImage: $selectedImage
            )
        }
    }
}

// MARK: - Preview

#Preview {

    ProfileView(
        viewModel: TaskViewModel()
    )
    .preferredColorScheme(.dark)
}
