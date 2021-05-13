//
//  ViewController.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 30/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var blueView: PhotosGridCustomView!
    @IBOutlet weak var topLeft_UIImage: UIImageView!
    @IBOutlet weak var topRight_UIImage: UIImageView!
    @IBOutlet weak var bottomLeft_UIImage: UIImageView!
    @IBOutlet weak var bottomRight_UIImage: UIImageView!
    
    @IBAction func photogridTypeButtonTouched(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            blueView.style = .twoSquaresBottom
            sender.setImage(#imageLiteral(resourceName: "Selected"), for: UIControl.State.normal)
        case 1:
            blueView.style = .twoSquaresUp
        case 2 :
            blueView.style = .fourSquares
        default:
            blueView.style = .fourSquares
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

