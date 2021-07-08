//
//  ProjectShelfView+Item.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 3.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit
import SnapKit

extension ProjectShelfView {

    class Item {
        weak var view: UIView?
        var constraints: Constraints

        struct Constraints {
            weak var leading: Constraint?
            weak var height: Constraint?
        }

        init(view: UIView?, constraints: Constraints) {
            self.view = view
            self.constraints = constraints
        }
    }

}

// MARK: -
// MARK: - Computed

extension ProjectShelfView.Item {

    var height: CGFloat? {
        return constraints.height?.layoutConstraints.first?.constant
    }

    var leadingMargin: CGFloat? {
        return constraints.leading?.layoutConstraints.first?.constant
    }

}
