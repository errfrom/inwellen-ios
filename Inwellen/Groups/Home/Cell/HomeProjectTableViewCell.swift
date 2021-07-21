//
//  HomeProjectTableViewCell.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 9.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class HomeProjectTableViewCell: UITableViewCell {

    // - Delegate
    private weak var delegate: HomeScreenDelegate?

    // - UI
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!

    // - Data
    private var projectPreview: ProjectPreviewModel!

    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: -
// MARK: - Set

extension HomeProjectTableViewCell {

    func set(projectPreview: ProjectPreviewModel, delegate: HomeScreenDelegate?) {
        self.projectPreview = projectPreview
        self.delegate = delegate

        projectNameLabel.text = projectPreview.projectName
        authorNameLabel.text = "by \(projectPreview.authorName)"
        coverImageView.image = projectPreview.coverImage
    }

}

// MARK: -
// MARK: - Action

fileprivate extension HomeProjectTableViewCell {

    @IBAction private func didTapMoveToProjectButton(_ sender: UIButton) {
        delegate?.didSelectProjectCell(projectPreview: projectPreview)
    }

}
