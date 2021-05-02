//
//  CreateCommitAudioTableViewCellLayoutManager.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CreateCommitAudioTableViewCellLayoutManager {
    
    private unowned let cell: CreateCommitAudioTableViewCell
    
    // - Init
    init(cell: CreateCommitAudioTableViewCell) {
        self.cell = cell
        configure()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CreateCommitAudioTableViewCellLayoutManager {
    
    private func configure() {
        configureScrollView()
        configureUploadCommitAudioLabel()
        configureSpecifyIntervalsLabel()
        configureBackButton()
    }
    
    private func configureScrollView() {
        cell.scrollViewContentWidthConstraint.constant = UIScreen.main.bounds.width * 2
    }
    
    private func configureUploadCommitAudioLabel() {
        cell.uploadCommitAudioLabel.addAttribute(.kern, value: 0.7)
    }
    
    private func configureSpecifyIntervalsLabel() {
        cell.specifyIntervalsLabel.addAttribute(.kern, value: 0.7)
        cell.specifyIntervalsLabel.alpha = 0
    }
    
    private func configureBackButton() {
        cell.backButton.isHidden = true
        cell.backButton.alpha = 0
    }
    
}
