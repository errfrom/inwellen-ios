//
//  AppColor.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/14/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

enum AppColor {
    static let ivory     = AppColor.color(fromHex: "F6EFE5")
    static let lightGray = AppColor.color(fromHex: "E9E5DF")
    static let darkGray  = AppColor.color(fromHex: "2B2F2B")
}

fileprivate extension AppColor {
    
    private static func color(fromHex hex: String, alpha: CGFloat = 1.0) -> UIColor {
        let cString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}
