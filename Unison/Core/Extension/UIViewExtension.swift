//
//  UIViewExtension.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
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
    
    func applyShadow(color: UIColor, offset: CGSize = .zero, blur: CGFloat = 0, opacity: Float = 1) {
        self.layoutIfNeeded()
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = blur / 2
        self.layer.shadowOpacity = opacity
        
        if self as? UILabel == nil {
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        }
    }
    
}
