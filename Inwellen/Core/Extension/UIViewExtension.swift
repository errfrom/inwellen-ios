//
//  UIViewExtension.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

// MARK: -
// MARK: - Inspectable

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get { return UIColor.init(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue?.cgColor  }
    }
    
}

// MARK: -
// MARK: - Shadow

extension UIView {

    // swiftlint:disable:next line_length
    func applyShadow(color: UIColor, offset: CGSize = .zero, blur: CGFloat = 0, opacity: Float = 1) {
        self.layoutIfNeeded()
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = blur / 2
        self.layer.shadowOpacity = opacity
        
        if self as? UILabel == nil {
            self.layer.shadowPath =
                UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        }
    }
    
}

// MARK: -
// MARK: - Animate

extension UIView {

    class func animate(
        withDuration duration: Double,
        dampingRatio: CGFloat,
        delay: Double = 0,
        velocity: CGFloat = 0,
        options: UIView.AnimationOptions = [],
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil) {

        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: dampingRatio,
            initialSpringVelocity: velocity,
            options: options,
            animations: animations,
            completion: completion
        )
    }

}
