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
    
}

// MARK: -
// MARK: - Set

extension SectionSeparatorTableViewCell {
    
    func set(sectionTitle: String, showSeparatorLine: Bool) {
        self.sectionTitleLabel.text = sectionTitle.uppercased()
        self.sectionTitleLabel.addAttribute(.kern, value: 0.7)
        self.separatorLineHeightConstraint.constant = showSeparatorLine ? 2 : 0
    }
    
}
