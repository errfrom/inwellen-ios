//
//  ScreenEmptyStateCell.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 21.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class ScreenEmptyStateCell: UITableViewCell {

    // - UI
    @IBOutlet weak var underlyingView: ScreenEmptyStateView!

    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: -
// MARK: - Interface

extension ScreenEmptyStateCell: IScreenEmptyStateView {

    func set(_ screenEmptyState: ScreenEmptyState) {
        underlyingView.set(screenEmptyState)
    }

}
