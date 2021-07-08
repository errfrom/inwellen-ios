//
//  ProjectShelfView+Constants.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 8.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import typealias UIKit.CGFloat

extension ProjectShelfView {

    struct Constants {
        let shelfHeight: CGFloat
        let secondaryItemTopMargin: CGFloat = 8
        let overlapMultiplier: CGFloat = 0.75
        let moveHeadForwardTranslationThreshold: CGFloat = -54
        let moveHeadBackwardTranslationThreshold: CGFloat = 20
        let makeNextItemHeadTranslationThreshold: CGFloat = -30

        var secondaryItemHeight: CGFloat {
            return shelfHeight - secondaryItemTopMargin
        }

        var secondaryItemVisibleWidth: CGFloat {
            return secondaryItemHeight * overlapMultiplier
        }

        var secondaryItemLeadingMargin: CGFloat {
            return secondaryItemHeight * overlapMultiplier
        }
    }

}
