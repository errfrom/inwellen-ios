//
//  HomeProjectTableViewCell.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 9.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class HomeProjectTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!

    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: -
// MARK: - Set

extension HomeProjectTableViewCell {

    func set(projectPreview: ProjectPreviewModel) {
        projectNameLabel.text = projectPreview.projectName
        authorNameLabel.text = "by \(projectPreview.authorName)"
        coverImageView.image = projectPreview.coverImage
    }

}
