//
//  ViewController.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 30/4/21.
//

import UIKit

class ViewController: UIViewController {

    private let imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var blueView: PhotosGridCustomView!
    @IBOutlet weak var topLeft_UIImage: UIImageView!
    @IBOutlet weak var topRight_UIImage: UIImageView!
    @IBOutlet weak var bottomLeft_UIImage: UIImageView!
    @IBOutlet weak var bottomRight_UIImage: UIImageView!
    @IBOutlet var layoutButtonsArray: [UIButton]!
    @IBOutlet weak var swipeToShare_StackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsPhotoFromAlbum(_:)))
        topLeft_UIImage.addGestureRecognizer(UITapGestureRecognizer)
        topRight_UIImage.addGestureRecognizer(UITapGestureRecognizer)
        bottomLeft_UIImage.addGestureRecognizer(UITapGestureRecognizer)
        bottomRight_UIImage.addGestureRecognizer(UITapGestureRecognizer)
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGestureToShareView(_:)))
        swipeToShare_StackView.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    @IBAction func photogridTypeButtonTouched(_ sender: UIButton) {
        layoutButtonsArray.forEach { button in
            button.isSelected = false
        }
        switch sender.tag {
        case 0:
            blueView.style = .twoSquaresBottom
        case 1:
            blueView.style = .twoSquaresUp
        case 2 :
            blueView.style = .fourSquares
        default:
            blueView.style = .fourSquares
        }
        setSelectedAppereanceForLayoutButton(sender: sender.tag)
    }
    
    private func setSelectedAppereanceForLayoutButton(sender: Int) {
        layoutButtonsArray[sender].isSelected = true
        layoutButtonsArray[sender].imageView?.contentMode = .scaleAspectFill
        layoutButtonsArray[sender].setImage(#imageLiteral(resourceName: "Selected"), for: .selected)
    }
    
    @objc func handleTapAddsPhotoFromAlbum(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            openUserPhotoAlbum()
            }
        
    }
    private func openUserPhotoAlbum() {
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.allowsEditing = true
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true)
    }
    
    
    @objc func handleSwipeGestureToShareView(_ sender: UISwipeGestureRecognizer ) {
//        let activityViewController = UIActivityViewController(activityItems: [blueView!], applicationActivities: nil)
//        present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
    
}
