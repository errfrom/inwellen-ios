//
//  NewProjectTextViewCellConfiguration.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 24.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import class UIKit.UIFont

enum NewProjectTextViewCellConfiguration: String, TextViewCellConfiguration {
    case projectNameTextView
    case projectDescriptionTextView
    case projectAuthorTextView

    var textFont: UIFont {
        switch self {
            case .projectNameTextView:
                return AppFont.suisseIntlMedium(size: 18)

            case .projectDescriptionTextView, .projectAuthorTextView:
                return AppFont.suisseIntlBook(size: 16)
        }
    }

    var hintText: String? {
        switch self {
            case .projectAuthorTextView:
                return localized("projectAuthorTextViewHint")

            default:
                return nil
        }
    }

    var charLimit: Int {
        switch self {
            case .projectNameTextView, .projectAuthorTextView:
                return 100

            case .projectDescriptionTextView:
                return 5000
        }
    }
    
}
