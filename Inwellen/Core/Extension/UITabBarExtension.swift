//
//  UITabBarExtension.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 2.08.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

extension UITabBar {
    private static let height: CGFloat = 200

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }

        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = UITabBar.height + window.safeAreaInsets.bottom
        return sizeThatFits
    }

}
