//
//  ViewControllerPhotoExtension.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 19/5/21.
//

import Foundation
import UIKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        selectedPlusImage?.image = selectedImage
        selectedPlusImage?.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
}
