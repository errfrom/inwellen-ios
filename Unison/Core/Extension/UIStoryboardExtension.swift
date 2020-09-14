//
//  UIStoryboardExtension.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/13/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
}
