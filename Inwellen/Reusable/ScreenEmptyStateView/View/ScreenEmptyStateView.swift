//
//  ScreenEmptyStateView.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 21.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class ScreenEmptyStateView: ReusableBaseView {

    // - UI
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!

    // - Lifecycle
    override func setupView() {
        super.setupView()
    }

}

// MARK: -
// MARK: - Interface

extension ScreenEmptyStateView: IScreenEmptyStateView {

    func set(_ screenEmptyState: ScreenEmptyState) {
        iconImageView.image = screenEmptyState.iconImage
        titleLabel.text = screenEmptyState.title
        hintLabel.text = screenEmptyState.hint
    }

}
