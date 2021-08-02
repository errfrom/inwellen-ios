//
//  CreateCommitTextViewCellConfiguration.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 24.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import class UIKit.UIFont
import typealias UIKit.CGFloat

enum CreateCommitTextViewCellConfiguration: String, TextViewCellConfiguration {
    var stringsTableName: String { "CreateCommitTextViewCellConfiguration" }

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

    var charLimit: Int {
        return 100
    }

    var minTextViewHeight: CGFloat {
        switch self {
            case .commitNameTextView, .commitDescriptionTextView:
                return 24
        }
    }

}
