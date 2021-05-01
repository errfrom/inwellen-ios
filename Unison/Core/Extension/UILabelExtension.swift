//
//  UILabelExtension.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

extension UILabel {
    
    func addAttribute(_ name: NSAttributedString.Key, value: Any) {
        let mutAttrString = self.attributedText != nil
            ? NSMutableAttributedString(attributedString: self.attributedText!)
            : NSMutableAttributedString(string: self.text ?? "")
        
        let length = self.attributedText != nil ? self.attributedText!.length : (self.text?.count ?? 0)
        mutAttrString.addAttribute(name, value: value, range: NSRange(location: 0, length: length))
        self.attributedText = mutAttrString
    }
    
}
