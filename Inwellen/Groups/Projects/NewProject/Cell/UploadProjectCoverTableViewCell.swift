//
//  UploadProjectCoverTableViewCell.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 29.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class UploadProjectCoverTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var coverImageView: UIImageView!

    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: -
// MARK: - Set

extension UploadProjectCoverTableViewCell {

    func set(coverImage: UIImage?) {
        self.coverImageView.image = coverImage

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.coverImageView.alpha = coverImage != nil ? 1 : 0
        }
    }

}
