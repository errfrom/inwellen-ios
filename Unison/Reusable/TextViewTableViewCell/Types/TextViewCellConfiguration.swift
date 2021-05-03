//
//  TextViewCellConfiguration.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

typealias TextViewCellType = TextViewCellConfiguration

enum TextViewCellConfiguration: CellConfiguration {
    case commitNameTextView
    case commitDescriptionTextView
    
    var placeholderText: String {
        switch self {
            case .commitNameTextView:
                return "Enter your commit name here..."
            
            case .commitDescriptionTextView:
                return "Enter your commit description here..."
        }
    }
    
    var textFont: UIFont {
        switch self {
            case .commitNameTextView:
                return AppFont.suisseIntlMedium(size: 18)
            
            case .commitDescriptionTextView:
                return AppFont.suisseIntlBook(size: 16)
        }
    }
    
    var minTextViewHeight: CGFloat {
        switch self {
            case .commitNameTextView, .commitDescriptionTextView:
                return 24
        }
    }
    
}
