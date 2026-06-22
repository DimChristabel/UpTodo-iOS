//
//  ProfileViewModel.swift
//  upToDo
//
//  Created by Maxut Consulting on 22/06/2026.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth
import UIKit

final class ProfileViewModel: ObservableObject {

    // MARK: User

    @Published var userName = ""

    @Published var currentUser: AppUser?

    // MARK: Profile Image

    @Published var profileImageData: Data?

    @Published var profileImageURL = ""

    @Published var isUploadingProfileImage = false

    // MARK: UI

    @Published var showChangeNameSheet = false

    @Published var showChangePasswordSheet = false

    @Published var isLoggedOut = false

    // MARK: Storage

    private let profileImageKey =
    "profile_image"

    init() {

        loadProfileImage()

        if Auth.auth().currentUser != nil {

            loadCurrentUser()
        }
    }

    // MARK: Logout

    func logout() {

        do {

            try AuthService.shared.logout()

            isLoggedOut = true

        } catch {

            print(
                "Logout Failed:",
                error.localizedDescription
            )
        }
    }

    // MARK: Load User

    func loadCurrentUser() {

        UserFirestoreService.shared
            .fetchCurrentUser {

                [weak self] result in

                DispatchQueue.main.async {

                    switch result {

                    case .success(let user):

                        self?.currentUser = user

                        self?.userName =
                        user.displayName

                    case .failure(let error):

                        print(
                            "Load User Error:",
                            error.localizedDescription
                        )
                    }
                }
            }
    }

    // MARK: Update Name

    func updateUserName(
        newName: String
    ) {

        guard let userId =
            currentUser?.id
        else {
            return
        }

        UserFirestoreService.shared
            .updateDisplayName(

                userId: userId,

                newName: newName

            ) { [weak self] result in

                DispatchQueue.main.async {

                    switch result {

                    case .success:

                        self?.currentUser?
                            .displayName =
                        newName

                        self?.userName =
                        newName

                    case .failure(let error):

                        print(
                            "Update Name Error:",
                            error.localizedDescription
                        )
                    }
                }
            }
    }

    // MARK: Upload Profile Image

    func uploadProfileImage(
        _ image: UIImage
    ) {

        guard let imageData =
            image.jpegData(
                compressionQuality: 0.8
            )
        else {
            return
        }

        guard let userId =
            currentUser?.id
        else {
            return
        }

        isUploadingProfileImage = true

        ProfileImageStorageService.shared
            .uploadProfileImage(

                imageData: imageData

            ) { [weak self] result in

                DispatchQueue.main.async {

                    switch result {

                    case .success(let imageURL):

                        UserFirestoreService.shared
                            .updateAvatarURL(

                                userId: userId,

                                avatarURL: imageURL

                            ) { firestoreResult in

                                DispatchQueue.main.async {

                                    self?.isUploadingProfileImage = false

                                    switch firestoreResult {

                                    case .success:

                                        self?.profileImageURL =
                                        imageURL

                                        self?.profileImageData =
                                        imageData

                                        self?.loadCurrentUser()

                                    case .failure(let error):

                                        print(
                                            error.localizedDescription
                                        )
                                    }
                                }
                            }

                    case .failure(let error):

                        self?.isUploadingProfileImage = false

                        print(
                            error.localizedDescription
                        )
                    }
                }
            }
    }

    // MARK: Change Password

    func changePassword(

        currentPassword: String,

        newPassword: String,

        completion: @escaping (
            Result<Void, Error>
        ) -> Void
    ) {

        AuthService.shared
            .reauthenticateAndChangePassword(

                currentPassword:
                currentPassword,

                newPassword:
                newPassword

            ) { result in

                DispatchQueue.main.async {

                    completion(result)
                }
            }
    }

    // MARK: Profile Image Helpers

    func saveProfileImage(
        _ image: UIImage
    ) {

        guard let data =
            image.jpegData(
                compressionQuality: 0.8
            )
        else {
            return
        }

        profileImageData = data

        UserDefaults.standard.set(
            data,
            forKey: profileImageKey
        )
    }

    private func loadProfileImage() {

        profileImageData =
        UserDefaults.standard.data(
            forKey: profileImageKey
        )
    }

    var profileUIImage: UIImage? {

        guard let data =
            profileImageData
        else {
            return nil
        }

        return UIImage(data: data)
    }
}
