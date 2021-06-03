//
//  UIViewExtension_ImageTransformer.swift
//  Instagrid
//
//  Created by JEAN SEBASTIEN BRUNET on 23/5/21.
//
// swiftlint:disable all

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

    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.45
        rotation.isCumulative = true
        rotation.repeatCount = 0.5
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
} // end of extension UIView
