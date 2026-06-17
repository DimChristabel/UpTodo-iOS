//
//  ImagePicker.swift
//  upToDo
//
//  Created by Maxut Consulting on 16/06/2026.
//

import SwiftUI
import UIKit

// MARK: - ImagePicker

/// A SwiftUI wrapper around UIImagePickerController.
///
/// Allows users to select an image from their photo
/// library and returns the selected image through
/// a binding.
struct ImagePicker: UIViewControllerRepresentable {

    // MARK: Properties

    @Binding
    var selectedImage: UIImage?

    // MARK: Coordinator

    func makeCoordinator() -> Coordinator {

        Coordinator(self)
    }

    // MARK: UIViewControllerRepresentable

    func makeUIViewController(
        context: Context
    ) -> UIImagePickerController {

        let picker =
        UIImagePickerController()

        picker.delegate =
        context.coordinator

        return picker
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: Context
    ) {}

    // MARK: Coordinator

    /// Handles communication between UIKit's
    /// UIImagePickerController and SwiftUI.
    final class Coordinator:
    NSObject,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {

        // MARK: Properties

        let parent: ImagePicker

        // MARK: Initializer

        init(
            _ parent: ImagePicker
        ) {

            self.parent = parent
        }

        // MARK: Image Selection

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {

            if let image =
                info[.originalImage]
                as? UIImage {

                parent.selectedImage = image
            }

            picker.dismiss(animated: true)
        }
    }
}
