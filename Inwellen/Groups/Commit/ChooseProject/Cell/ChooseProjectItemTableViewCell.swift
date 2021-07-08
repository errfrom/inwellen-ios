//
//  ChooseProjectItemTableViewCell.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class ChooseProjectItemTableViewCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var projectCoverImageView: UIImageView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var projectAuthorLabel: UILabel!
    
}

// MARK: -
// MARK: - Set

extension ChooseProjectItemTableViewCell {
    
    func set(model: ChooseProjectItemTestModel) {
        self.projectCoverImageView.image = model.coverImage
        self.projectTitleLabel.text = model.projectTitle
        self.projectAuthorLabel.text = "by \(model.projectAuthor)"
    }
    
}
