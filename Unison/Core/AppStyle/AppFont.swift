//
//  AppFont.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

enum AppFont: String {
    
    case suisseIntlRegular = "SuisseIntl-Regular"
    case suisseIntlMedium = "SuisseIntl-Medium"
    case simplonNormBold = "SimplonNorm-Bold"
    
    // - Suisse Intl
    static func suisseIntlRegular(size: CGFloat) -> UIFont {
        return UIFont(name: suisseIntlRegular.rawValue, size: size)!
    }
    
    static func suisseIntlMedium(size: CGFloat) -> UIFont {
        return UIFont(name: suisseIntlMedium.rawValue, size: size)!
    }
    
    // - Simplon Norm
    static func simplonNormBold(size: CGFloat) -> UIFont {
        return UIFont(name: simplonNormBold.rawValue, size: size)!
    }
    
}
