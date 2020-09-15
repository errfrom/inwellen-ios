//
//  WaveformSelectedIntervalView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/14/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

class WaveformSelectedIntervalView: UIView {
    
    // - UI
    @IBOutlet weak var intervalView: UIView!
    
    // - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = Bundle(for: type(of: self)).loadNibNamed("\(WaveformSelectedIntervalView.self)", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(WaveformSelectedIntervalView.self): init from storyboard forbidden.")
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension WaveformSelectedIntervalView {
    
    private func configure() {
        configureIntervalView()
    }
    
    private func configureIntervalView() {
        intervalView.layer.cornerRadius = 1.5
    }
    
}
