//
//  ViewController.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 30/4/21.
//
// swiftlint:disable all

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
    private var firstStart = true

    // ==============================================
    // MARK: - @IBOutlets
    // ==============================================

    @IBOutlet weak var blueView: UIView!
    @IBOutlet var topStackView: UIStackView!
    @IBOutlet var bottomStackView: UIStackView!
    @IBOutlet weak var topLeftUIImage: UIImageView!
    @IBOutlet weak var topRightUIImage: UIImageView!
    @IBOutlet weak var bottomLeftUIImage: UIImageView!
    @IBOutlet weak var bottomRightUIImage: UIImageView!
    @IBOutlet var layoutButtonsArray: [UIButton]!
    @IBOutlet weak var swipeToShareStackView: UIStackView!

    // ==============================================
    // MARK: - View lifecycle functions
    // ==============================================

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        photogridTypeButtonTouched(layoutButtonsArray[1])

        let topLeftUITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsTL(_:)))
        topLeftUITapGestureRecognizer.name = "TL"
        topLeftUIImage.addGestureRecognizer(topLeftUITapGestureRecognizer)
        let topRightUITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsTL(_:)))
        topRightUITapGestureRecognizer.name = "TR"
        topRightUIImage.addGestureRecognizer(topRightUITapGestureRecognizer)
        let bottomLeftUITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsTL(_:)))
        bottomLeftUITapGestureRecognizer.name = "BL"
        bottomLeftUIImage.addGestureRecognizer(bottomLeftUITapGestureRecognizer)
        let bottomRightUITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAddsTL(_:)))
        bottomRightUITapGestureRecognizer.name = "BR"
        bottomRightUIImage.addGestureRecognizer(bottomRightUITapGestureRecognizer)

        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGestureToShareView(_:)))
        guard let swipeGestureRecognizer = swipeGesture else { return }
        swipeToShareStackView.addGestureRecognizer(swipeGestureRecognizer)

        myImagePickerController.delegate = self

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        detectOrientation()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if firstStart {
            firstStart = false
            detectOrientation()
        }
    }

    // ==============================================
    // MARK: - Enum and function to set grid type
    // ==============================================

    /// This enum defines 3 styles that change the photogrid layout.
    enum PhotoGridStackViewStyle {
        case fourSquares, twoSquaresUp, twoSquaresBottom
    }

    /// This function hides or unhides subviews of a given stack view,
    /// depending on a style received in paramater.
    /// - This function is used in var style in a didSet method.
    /// - Parameter style : an enum type received
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

    /// This action changes the grid's layout whenever a button is touched.
    /// - Parameter _ : a UIButton that was touched up by user.
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

    /// This function maintains the touched button property "isSelected" to true,
    /// so that the check mark stays visible to user until another button is touched.
    /// - Parameter sender : an Int value reprensenting the tag of a given
    /// touched button.
    private func setSelectedAppereanceForLayoutButton(sender: Int) {
        layoutButtonsArray[sender].isSelected = true
        layoutButtonsArray[sender].imageView?.contentMode = .scaleAspectFit
        layoutButtonsArray[sender].setImage(#imageLiteral(resourceName: "Selected_1024"), for: .selected)
    }

    /// This function sets the ImagePickerController's source type
    /// to photoLibrary, and presents the Image picker controller.
    private func openUserPhotoAlbum() {
        myImagePickerController.sourceType = .photoLibrary
        myImagePickerController.allowsEditing = true
        present(myImagePickerController, animated: true)
    }

    /// This function first transforms the photo grid to a flattened image,
    /// calling the property transformMainBlueViewToImage, declared
    /// in an UIView extension. Then the function presents the
    /// activity controller and make the photo grid reapper with
    /// an animation.
    private func share() {
        guard let myImage = blueView.transformMainBlueViewToImage else { return }

        let activityViewController = UIActivityViewController(activityItems: [myImage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.1, options: [], animations: {
                self.blueView.transform = .identity
            }, completion: nil)
        }
    }

    // ==============================================
    // MARK: - @objc Functions
    // ==============================================

    /// This function changes images in a touched up UIImageView
    /// - Parameter _ : A UITapGestureRecognizer
    @objc func handleTapAddsTL(_ sender: UITapGestureRecognizer) {
        switch sender.name {
        case "TL":
            selectedPlusImage = topLeftUIImage
        case "TR":
            selectedPlusImage = topRightUIImage
        case "BL":
            selectedPlusImage = bottomLeftUIImage
        case "BR":
            selectedPlusImage = bottomRightUIImage
        default:
            break
        }
            openUserPhotoAlbum()
    }

    /// This function animates the photo grid depending on the swipe gesture
    /// direction. The function share() is called once the gesture is completed
    /// by user.
    /// - Parameter _ : A UISwipeGestureRecognizer
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

    /// This function changes the swipe gesture
    /// direction accordingly to device's orientation.
    @objc private func detectOrientation() {
        if UIDevice.current.orientation.isLandscape {
            swipeGesture?.direction = .left
        } else {
            swipeGesture?.direction = .up
        }
    }

}
