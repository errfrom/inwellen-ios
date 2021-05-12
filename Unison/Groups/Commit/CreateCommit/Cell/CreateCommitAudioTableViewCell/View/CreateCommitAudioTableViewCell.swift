//
//  CreateCommitAudioTableViewCell.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CreateCommitAudioTableViewCell: UITableViewCell {
    
    // - Delegate
    private(set) weak var delegate: CreateCommitScreenDelegate?
    
    // - UI
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContentView: UIView!
              weak var containerView: UIView?
    
    @IBOutlet weak var uploadCommitAudioLabel: UILabel!
    @IBOutlet weak var specifyIntervalsLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // - Constraints
    @IBOutlet weak var scrollViewContentWidthConstraint: NSLayoutConstraint!
    @IBOutlet      var uploadAudioFileViewTopBottomConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var uploadCommitAudioLabelLeadingConstraint: NSLayoutConstraint!
    
    // - Manager
    private var layoutManager: CreateCommitAudioTableViewCellLayoutManager?
    
    // - Types
    enum Page: Int {
        case uploadAudioFilePage
        case specifyIntervalsPage
    }
    
    // - Data
    private(set) var currentPage: Page = .uploadAudioFilePage
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
}

// MARK: -
// MARK: - Set

extension CreateCommitAudioTableViewCell {
    
    func set(delegate: CreateCommitScreenDelegate?, page: Page) {
        self.delegate = delegate
        
        if page != currentPage {
            self.currentPage = page
            layoutManager?.layoutPagesTransition()
        }
    }
    
}

// MARK: -
// MARK: - Action

fileprivate extension CreateCommitAudioTableViewCell {
    
    @IBAction private func didTapUploadAudioFileButton(_ sender: UIButton) {
        delegate?.didTapUploadAudioFileButton()
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
