//
//  TextViewCellConfiguration.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 24.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
// 

import class UIKit.UIFont
import typealias UIKit.CGFloat

protocol TextViewCellConfiguration: Localizable, CellConfiguration {
    var placeholderText: String { get }
    var hintText: String? { get }
    var textFont: UIFont { get }
    var charLimit: Int { get }

    var minTextViewHeight: CGFloat { get }
}

// MARK: -
// MARK: - Default

extension TextViewCellConfiguration {

    var placeholderText: String {
        return localized
    }

    var hintText: String? {
        return nil
    }

    var minTextViewHeight: CGFloat {
        return 24
    }

}
