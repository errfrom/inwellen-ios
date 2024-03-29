//
//  CreateCommitChooseProjectTableViewCell.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class CreateCommitChooseProjectTableViewCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var contentView_: UIView!
    
    // - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        contentViewApplyShadow()
    }
    
}

// MARK: -
// MARK: - Shadow

fileprivate extension CreateCommitChooseProjectTableViewCell {
    
    private func contentViewApplyShadow() {
        contentView_.applyShadow(color: AppColor.richBlack, blur: 10, opacity: 0.06)
    }
    
}
