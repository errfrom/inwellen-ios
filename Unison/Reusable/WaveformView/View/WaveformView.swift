//
//  WaveformView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/11/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class WaveformView: ReusableBaseView {
    
    // - UI
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var contentView: UIView!
    
    // - Lifecycle
    override func setupView() {
        super.setupView()
        
        let interval = CommitSelectedIntervalView(frame: CGRect(x: 60, y: 0, width: 70 + 44, height: self.bounds.height))
        view.insertSubview(interval, belowSubview: contentView)
    }
    
}
