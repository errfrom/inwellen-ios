//
//  StringExtension.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 24.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

// MARK: -
// MARK: - Localization

extension String {

    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(
            self,
            tableName: tableName,
            bundle: .main,
            value: "**\(self)**",
            comment: ""
        )
    }

}

// MARK: -
// MARK: - Layout

extension String {

    func width(usingFont font: UIFont) -> CGFloat {
        return self.size(withAttributes: [.font: font]).width
    }

}
