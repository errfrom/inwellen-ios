//
//  CommitSelectedIntervalViewLayoutManager.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/15/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class CommitSelectedIntervalViewLayoutManager {
    
    private unowned let view: CommitSelectedIntervalView
    
    // - Init
    init(view: CommitSelectedIntervalView) {
        self.view = view
        configure()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CommitSelectedIntervalViewLayoutManager {
    
    private func configure() {
        configureTimeLabels()
    }
    
    private func configureTimeLabels() {
        [view.startTimeLabel, view.endTimeLabel].forEach {
            $0.addAttribute(.kern, value: 0.6)
        }
    }
    
}
