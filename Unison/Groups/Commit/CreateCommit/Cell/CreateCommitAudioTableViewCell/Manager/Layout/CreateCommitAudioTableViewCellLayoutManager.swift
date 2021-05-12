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
        // layoutSectionSeparatorLabels()
        adjustUploadCommitAudioLabelAppearance()
        scrollViewUpdateContentOffset()
        reprioritizeConstraints()
    }
    
    private func layoutSectionSeparatorLabels() {
        let constraintPriority = UILayoutPriority(cell.currentPage == .uploadAudioFilePage ? 1000 : 998)
        cell.uploadCommitAudioLabelLeadingConstraint.priority = constraintPriority
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
// MARK: - Appearance

fileprivate extension CreateCommitAudioTableViewCellLayoutManager {
    
    private func adjustUploadCommitAudioLabelAppearance() {
        let animationOptions: UIView.AnimationOptions = [.transitionCrossDissolve, .curveEaseOut]
        UIView.transition(with: cell.uploadCommitAudioLabel, duration: 0.25, options: animationOptions, animations: { [weak self] in
            guard let strongSelf = self else { return }
            
            let text = strongSelf.cell.currentPage == .uploadAudioFilePage ? "Upload commit audio" : "Back"
            strongSelf.cell.uploadCommitAudioLabel.text = text.uppercased()
        })
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CreateCommitAudioTableViewCellLayoutManager {
    
    private func configure() {
        configureScrollView()
        configureContainerView()
        configureSpecifyIntervalsViewController()
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
    
    private func configureSpecifyIntervalsViewController() {
        guard let containerView = cell.containerView else { return }
        
        let current_vc = UIApplication.shared.currentViewController
        let specifyIntervals_vc = Storyboard.specifyIntervals.viewController as! SpecifyIntervalsScreenViewController
        current_vc?.addChild(specifyIntervals_vc)
        specifyIntervals_vc.willMove(toParent: current_vc)
        
        containerView.addSubview(specifyIntervals_vc.view)
        specifyIntervals_vc.view.frame = containerView.bounds
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
