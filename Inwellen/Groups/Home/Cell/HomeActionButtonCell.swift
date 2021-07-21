//
//  HomeActionButtonCell.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 21.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class HomeActionButtonCell: UITableViewCell {

    // - UI
    @IBOutlet weak var underlyingButton: UIButton!

    // - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        underlyingButton.cornerRadius = 14

        if #available(iOS 13.0, *) {
            underlyingButton.layer.cornerCurve = .continuous
        }
    }

}
