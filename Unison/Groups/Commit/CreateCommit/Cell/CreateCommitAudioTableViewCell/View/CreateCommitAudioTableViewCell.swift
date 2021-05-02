//
//  CreateCommitAudioTableViewCell.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CreateCommitAudioTableViewCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var uploadCommitAudioLabel: UILabel!
    @IBOutlet weak var specifyIntervalsLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // - Constraints
    @IBOutlet weak var scrollViewContentWidthConstraint: NSLayoutConstraint!
    
    // - Manager
    private var layoutManager: CreateCommitAudioTableViewCellLayoutManager!
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CreateCommitAudioTableViewCell {
    
    private func configure() {
        configureLayoutManager()
    }
    
    private func configureLayoutManager() {
        layoutManager = CreateCommitAudioTableViewCellLayoutManager(cell: self)
    }
    
}
