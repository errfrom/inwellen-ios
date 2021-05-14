//
//  CommitSelectedIntervalView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/14/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CommitSelectedIntervalView: ReusableBaseView {
    
    // - UI
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    // - Manager
    private var layoutManager: CommitSelectedIntervalViewLayoutManager!
    
    // - Lifecycle
    override func setupView() {
        super.setupView()
        configure()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CommitSelectedIntervalView {
    
    private func configure() {
        configureLayoutManager()
    }
    
    private func configureLayoutManager() {
        layoutManager = CommitSelectedIntervalViewLayoutManager(view: self)
    }
    
}
