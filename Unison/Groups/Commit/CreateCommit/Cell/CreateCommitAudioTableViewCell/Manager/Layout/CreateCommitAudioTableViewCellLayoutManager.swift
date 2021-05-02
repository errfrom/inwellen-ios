//
//  CreateCommitAudioTableViewCellLayoutManager.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit
import SnapKit

class CreateCommitAudioTableViewCellLayoutManager {
    
    private unowned let cell: CreateCommitAudioTableViewCell
    
    // - Init
    init(cell: CreateCommitAudioTableViewCell) {
        self.cell = cell
        configure()
    }
    
}

// MARK: -
// MARK: - Layout

extension CreateCommitAudioTableViewCellLayoutManager {
    
    func layoutPagesTransition() {
        scrollViewUpdateContentOffset()
        reprioritizeConstraints()
    }
    
    private func reprioritizeConstraints() {
        let constraintPriority = UILayoutPriority(cell.currentPage == .uploadAudioFilePage ? 1000 : 998)
        cell.uploadAudioFileViewTopBottomConstraints.forEach() {
            $0.priority = constraintPriority
        }
    }
    
    private func scrollViewUpdateContentOffset() {
        let screenWidth = UIScreen.main.bounds.width
        let contentOffset = CGPoint(x: screenWidth * CGFloat(cell.currentPage.rawValue), y: 0)
        cell.scrollView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.cell.scrollView.setContentOffset(contentOffset, animated: false)
        }, completion: { [weak self] _ in
            self?.cell.delegate?.commitAudioCellDidPerformPageTransition()
        })
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CreateCommitAudioTableViewCellLayoutManager {
    
    private func configure() {
        configureScrollView()
        configureContainerView()
        configureUploadCommitAudioLabel()
        configureSpecifyIntervalsLabel()
        configureBackButton()
    }
    
    private func configureScrollView() {
        cell.scrollViewContentWidthConstraint.constant = UIScreen.main.bounds.width * 2
    }
    
    private func configureContainerView() {
        let containerView = UIView()
        containerView.backgroundColor = .blue
        cell.scrollViewContentView.addSubview(containerView)
        cell.containerView = containerView
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(600)
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().priority(999)
        }
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
