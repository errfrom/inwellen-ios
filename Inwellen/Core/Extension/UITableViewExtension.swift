//
//  UITableViewExtension.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 25.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

extension UITableView {

    func updateRowHeightsWithoutReloading(animated: Bool) {
        if animated {
            beginUpdates(); endUpdates()
        } else {
            UIView.performWithoutAnimation {
                beginUpdates(); endUpdates()
            }
        }
    }

}
