//
//  ViewController.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 30/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    // ==============================================
    // MARK: - Private Properties
    // ==============================================
    
    private let imagePickerController = UIImagePickerController()
    private var style: PhotoGridStackViewStyle = .fourSquares {
        didSet {
            setStyle(style: style)
        }
    }
    private var selectedPlusImage: UIImageView?
    
    // ==============================================
    // MARK: - Outlets
    // ==============================================
    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet var topStackView: UIStackView!
    @IBOutlet var bottomStackView: UIStackView!
    @IBOutlet weak var topLeft_UIImage: UIImageView!
    @IBOutlet weak var topRight_UIImage: UIImageView!
    @IBOutlet weak var bottomLeft_UIImage: UIImageView!
    @IBOutlet weak var bottomRight_UIImage: UIImageView!
    @IBOutlet var layoutButtonsArray: [UIButton]!
    @IBOutlet weak var swipeToShare_StackView: UIStackView!
    
    // ==============================================
    // MARK: - Function viewDidLoad()
    // ==============================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        photogridTypeButtonTouched(layoutButtonsArray[1])
        
        let TL_UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsPhotoFromAlbum(_:)))
        topLeft_UIImage.addGestureRecognizer(TL_UITapGestureRecognizer)
        let TR_UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsPhotoFromAlbum(_:)))
        topRight_UIImage.addGestureRecognizer(TR_UITapGestureRecognizer)
        let BT_UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsPhotoFromAlbum(_:)))
        bottomLeft_UIImage.addGestureRecognizer(BT_UITapGestureRecognizer)
        let BR_UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsPhotoFromAlbum(_:)))
        bottomRight_UIImage.addGestureRecognizer(BR_UITapGestureRecognizer)
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGestureToShareView(_:)))
        swipeToShare_StackView.addGestureRecognizer(swipeGestureRecognizer)
        
        imagePickerController.delegate = self
        
    }

    // ==============================================
    // MARK: - Enum and func to set grid type
    // ==============================================

    enum PhotoGridStackViewStyle {
        case fourSquares, twoSquaresUp, twoSquaresBottom
    }

    private func setStyle(style: PhotoGridStackViewStyle) {
        switch style {
        case .fourSquares:
            topStackView.arrangedSubviews[0].isHidden = false
            bottomStackView.arrangedSubviews[0].isHidden = false
        case .twoSquaresBottom :
            topStackView.arrangedSubviews[0].isHidden = true
            bottomStackView.arrangedSubviews[0].isHidden = false
        case .twoSquaresUp :
            bottomStackView.arrangedSubviews[0].isHidden = true
            topStackView.arrangedSubviews[0].isHidden = false
        }
    }

    // ==============================================
    // MARK: - @IBActions
    // ==============================================

    @IBAction func photogridTypeButtonTouched(_ sender: UIButton) {
        layoutButtonsArray.forEach { button in button.isSelected = false }
        switch sender.tag {
        case 0:
            style = .twoSquaresBottom
        case 1:
            style = .twoSquaresUp
        case 2 :
            style = .fourSquares
        default:
            style = .fourSquares
        }
        setSelectedAppereanceForLayoutButton(sender: sender.tag)
    }

    // ==============================================
    // MARK: - Private Functions
    // ==============================================

    private func setSelectedAppereanceForLayoutButton(sender: Int) {
        layoutButtonsArray[sender].isSelected = true
        layoutButtonsArray[sender].imageView?.contentMode = .scaleAspectFit
        layoutButtonsArray[sender].setImage(#imageLiteral(resourceName: "Selected_1024"), for: .selected)
    }

    private func openUserPhotoAlbum() {
//
    }

    // ==============================================
    // MARK: - @objc Functions
    // ==============================================
    @objc func handleTapAddsPhotoFromAlbum(_ sender: UITapGestureRecognizer) {
        print("tapGestureIsWorking")
        selectedPlusImage = topLeft_UIImage
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
        
//            openUserPhotoAlbum()
    }

    @objc func handleSwipeGestureToShareView(_ sender: UISwipeGestureRecognizer ) {
//        let activityViewController = UIActivityViewController(activityItems: [blueView!], applicationActivities: nil)
//        present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        selectedPlusImage?.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}

