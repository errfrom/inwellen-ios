//
//  AlertEnum.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 31.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import class UIKit.UIAlertController

enum Alert: String, Localizable {
    case discardChanges

    var controller: UIAlertController {
        return UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
    }

    var stringsTableName: String {
        return "AlertEnum"
    }

}

// MARK: -
// MARK: - Alert Title & Message

fileprivate extension Alert {

    private var alertTitle: String {
        return localized(rawValue + "AlertTitle")
    }

    private var alertMessage: String {
        return localized(rawValue + "AlertMessage")
    }

}
