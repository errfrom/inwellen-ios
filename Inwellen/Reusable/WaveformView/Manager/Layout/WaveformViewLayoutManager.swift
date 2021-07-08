//
//  WaveformViewLayoutManager.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/23/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit
import SnapKit

class WaveformViewLayoutManager {
    
    private unowned let view: WaveformView
    
    // - Init
    init(view: WaveformView) {
        self.view = view
    }
    
}

// MARK: -
// MARK: - View Hierarchy

extension WaveformViewLayoutManager {
    
    func insert(intervalView: CommitSelectedIntervalView, intervalViewMinX: CGFloat) {
        view.view.insertSubview(intervalView, belowSubview: view.contentView)
        
        intervalView.snp.makeConstraints { make in
            make.leading.equalTo(view.interactiveArea).offset(intervalViewMinX)
            make.top.height.equalToSuperview()
        }
    }
    
}
