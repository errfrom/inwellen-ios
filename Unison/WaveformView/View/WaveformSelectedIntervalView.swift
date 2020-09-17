//
//  WaveformSelectedIntervalView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/14/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

class WaveformSelectedIntervalView: UIView {
    
    // - Delegate
    private unowned var delegate: WaveformIntervalViewDelegate!
 
    // - Data
    var intervalID: Int!
    var selected: Bool = true
    
    // - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        init_()
    }
    
    private func init_() {
        let view = Bundle(for: type(of: self)).loadNibNamed("\(WaveformSelectedIntervalView.self)", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(WaveformSelectedIntervalView.self): init from storyboard forbidden.")
    }
    
}

// MARK: -
// MARK: - Set

extension WaveformSelectedIntervalView {
    
    func set(intervalID: Int, delegate: WaveformIntervalViewDelegate) {
        self.intervalID = intervalID
        self.delegate = delegate
    }
    
}

// MARK: -
// MARK: - Gesture Recognizer

fileprivate extension WaveformSelectedIntervalView {
    
    @IBAction private func didRecognizeTapGesture(_ gesture: UITapGestureRecognizer) {
        delegate.shouldSelectInterval(intervalID: intervalID)
    }
    
    @IBAction private func didRecognizeLeftEdgePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard selected else { return }
        print("log: recognized left edge pan gesture")
    }
    
    @IBAction private func didRecognizeRightEdgePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard selected else { return }
        print("log: recoginzed right edge pan gesture")
    }
    
}
