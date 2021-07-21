//
//  ScreenEmptyStateEnum.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 21.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import class UIKit.UIImage

enum ScreenEmptyState {
    case homeScreenEmptyState

    var title: String {
        switch self {
            case .homeScreenEmptyState:
                return "You don’t have any projects"
        }
    }

    var hint: String {
        switch self {
            case .homeScreenEmptyState:
                return "Create your own project or become a member "
                     + "of an existing one by invitation."
        }
    }

    var iconImage: UIImage? {
        switch self {
            case .homeScreenEmptyState:
                return UIImage(named: "homeEmptyState")
        }
    }

}
