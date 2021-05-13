//
//  PhotosGridCustomView.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 13/5/21.
//

import UIKit

class PhotosGridCustomView: UIView {

    @IBOutlet var topStackView: UIStackView!
    @IBOutlet var bottomStackView: UIStackView!

    enum Style {
        case fourSquares, twoSquaresUp, twoSquaresBottom
    }

    var style: Style = .fourSquares {
        didSet {
            setStyle(style: style)
        }
    }

    private func setStyle(style: Style) {
        switch style {
        case .fourSquares:
            topStackView.arrangedSubviews[0].isHidden = false
            bottomStackView.arrangedSubviews[0].isHidden = false
        case .twoSquaresBottom :
            topStackView.arrangedSubviews[0].isHidden = true
        case .twoSquaresUp :
            bottomStackView.arrangedSubviews[0].isHidden = false
        }
    }

}
