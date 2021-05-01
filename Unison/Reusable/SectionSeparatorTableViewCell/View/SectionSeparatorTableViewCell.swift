//
//  SectionSeparatorTableViewCell.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class SectionSeparatorTableViewCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    // - Constraints
    @IBOutlet weak var separatorLineHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var separatorLineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sectionTitleBottomConstraint: NSLayoutConstraint!
    
}

// MARK: -
// MARK: - Set

extension SectionSeparatorTableViewCell {
    
    func set(withConfig config: SectionSeparatorCellConfiguration) {
        self.sectionTitleLabel.text = config.sectionTitle.uppercased()
        self.sectionTitleLabel.addAttribute(.kern, value: 0.7)
        
        self.separatorLineHeightConstraint.constant = config.shouldShowSeparatorLine ? 2 : 0
        self.separatorLineTopConstraint.constant = config.topMargin
        self.sectionTitleBottomConstraint.constant = config.bottomMargin
    }
    
}
