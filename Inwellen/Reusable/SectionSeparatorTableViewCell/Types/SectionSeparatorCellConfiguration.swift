//
//  SectionSeparatorCellConfiguration.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

struct SectionSeparatorCellConfiguration: CellConfiguration {

    let sectionTitle: String
    let shouldShowSeparatorLine: Bool
    let topMargin: CGFloat
    let bottomMargin: CGFloat
    
    init(_ sectionTitle: String,
         showSeparatorLine: Bool = true,
         topMargin: CGFloat = 0,
         bottomMargin: CGFloat = 0) {
        
        self.sectionTitle = sectionTitle
        self.shouldShowSeparatorLine = showSeparatorLine
        self.topMargin = topMargin
        self.bottomMargin = bottomMargin
    }
    
}
