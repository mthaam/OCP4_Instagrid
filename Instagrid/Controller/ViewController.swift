//
//  ViewController.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 30/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    // ==============================================
    // MARK: - Properties
    // ==============================================
    
    private let myImagePickerController = UIImagePickerController()
    private var style: PhotoGridStackViewStyle = .fourSquares {
        didSet {
            setStyle(style: style)
        }
    }
    var selectedPlusImage: UIImageView?
    private var swipeGesture: UISwipeGestureRecognizer?
    
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

        let TL_UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsTL(_:)))
        TL_UITapGestureRecognizer.name = "TL"
        topLeft_UIImage.addGestureRecognizer(TL_UITapGestureRecognizer)
        let TR_UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsTL(_:)))
        TR_UITapGestureRecognizer.name = "TR"
        topRight_UIImage.addGestureRecognizer(TR_UITapGestureRecognizer)
        let BL_UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsTL(_:)))
        BL_UITapGestureRecognizer.name = "BL"
        bottomLeft_UIImage.addGestureRecognizer(BL_UITapGestureRecognizer)
        let BR_UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsTL(_:)))
        BR_UITapGestureRecognizer.name = "BR"
        bottomRight_UIImage.addGestureRecognizer(BR_UITapGestureRecognizer)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGestureToShareView(_:)))
        guard let swipeGestureRecognizer = swipeGesture else { return }
        swipeToShare_StackView.addGestureRecognizer(swipeGestureRecognizer)
        
        myImagePickerController.delegate = self
        
    }

    // ==============================================
    // MARK: - Function viewWillTransition()
    // ==============================================

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            swipeGesture?.direction = .left
        } else {
            swipeGesture?.direction = .up
        }
    }

    // ==============================================
    // MARK: - Enum and function to set grid type
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
        myImagePickerController.sourceType = .photoLibrary
        myImagePickerController.allowsEditing = true
        present(myImagePickerController, animated: true)
    }
    
    private func share() {
        guard let myImage = blueView.transformMainBlueViewToImage else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [myImage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            UIView.animate(withDuration: 0.5) {
                self.blueView.transform = .identity
            }
        }
    }

    // ==============================================
    // MARK: - @objc Functions
    // ==============================================
    @objc func handleTapAddsTL(_ sender: UITapGestureRecognizer) {
        switch sender.name {
        case "TL":
            selectedPlusImage = topLeft_UIImage
        case "TR":
            selectedPlusImage = topRight_UIImage
        case "BL":
            selectedPlusImage = bottomLeft_UIImage
        case "BR":
            selectedPlusImage = bottomRight_UIImage
        default:
            break
        }
            openUserPhotoAlbum()
    }

    @objc func handleSwipeGestureToShareView(_ sender: UISwipeGestureRecognizer ) {
        if swipeGesture?.direction == .up {
            UIView.animate(withDuration: 0.6, delay: 0, options: []) {
                self.blueView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            } completion: { _ in
                self.share()
            }
        } else {
            UIView.animate(withDuration: 0.6, delay: 0, options: []) {
                self.blueView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            } completion: { _ in
                self.share()
            }
        }
    }

}

extension UIView {
    /// allows to transform the mainBlueView grid into a simple image
    var transformMainBlueViewToImage: UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}

