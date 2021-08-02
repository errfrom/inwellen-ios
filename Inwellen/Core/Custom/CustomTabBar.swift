//
//  CustomTabBar.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 2.08.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class CustomTabBar: UITabBar {
    private static let height: CGFloat = 46

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }

        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = CustomTabBar.height + window.safeAreaInsets.bottom
        return sizeThatFits
    }

}
