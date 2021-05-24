//
//  UIViewExtension_ImageTransformer.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 23/5/21.
//

import Foundation
import UIKit

/// This extension allows to transform the photo  grid into a flattened image
extension UIView {
    
    /// This calcultated property transforms the photo grid into a flattened image
    var transformMainBlueViewToImage: UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}
