//
//  ViewController.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 30/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addPhotoFromAlbum))
        
    }
    
    @IBOutlet weak var blueView: PhotosGridCustomView!
    @IBOutlet weak var topLeft_UIImage: UIImageView!
    @IBOutlet weak var topRight_UIImage: UIImageView!
    @IBOutlet weak var bottomLeft_UIImage: UIImageView!
    @IBOutlet weak var bottomRight_UIImage: UIImageView!
    @IBOutlet var layoutButtonsArray: [UIButton]!
    @IBOutlet weak var swipeToShare_StackView: UIStackView!
    
    
    
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
    
    @objc func addPhotoFromAlbum() {
        
    }
    
    
    



}

