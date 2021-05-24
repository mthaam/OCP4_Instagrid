//
//  ViewControllerPhotoExtension.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 19/5/21.
//
// swiftlint:disable all

import Foundation
import UIKit

/// This extension conforms to 2 protocols :
/// UIImagePickerControllerDelegate and UINavigationControllerDelegate
/// The function imagePickerController is set to be able for a user
/// to choose an image in its gallery/
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        selectedPlusImage?.image = selectedImage
        selectedPlusImage?.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
}
