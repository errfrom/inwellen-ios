//
//  ImagePickerAction.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 25.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import class UIKit.UIAlertAction

enum ImagePickerAction: String, Localizable {
    case cameraAction
    case chooseImageAction
    case removeImageAction
    case cancelAction

    func alertAction(handler: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: localized, style: actionStyle) { _ in handler?() }
    }

    private var actionStyle: UIAlertAction.Style {
        switch self {
            case .cameraAction, .chooseImageAction:
                return .default

            case .removeImageAction:
                return .destructive

            case .cancelAction:
                return .cancel
        }
    }

}
