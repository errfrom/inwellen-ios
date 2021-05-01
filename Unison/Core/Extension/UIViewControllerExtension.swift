//
//  UIViewControllerExtension.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @discardableResult func hideKeyboardWhenTappedAround() -> UITapGestureRecognizer {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        return tap
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}
