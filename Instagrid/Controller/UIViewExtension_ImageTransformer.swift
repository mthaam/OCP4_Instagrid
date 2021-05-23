//
//  UIViewExtension_ImageTransformer.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 23/5/21.
//

import Foundation
import UIKit

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
