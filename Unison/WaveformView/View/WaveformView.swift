//
//  WaveformView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/13/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

class WaveformView: UIView {
    
    // - UI
    @IBOutlet weak var waveformInternalView: WaveformInternalView!
    @IBOutlet weak var _waveformSelectedInterval: WaveformSelectedIntervalView?
    
    // - Manager
    private var layoutManager: WaveformViewLayoutManager!
    
    // - State
    private var state: WaveformViewState!
    
    // - Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = Bundle(for: type(of: self)).loadNibNamed("\(WaveformView.self)", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        configure()
    }
    
}

// MARK: -
// MARK: - WaveformViewStateDelegate

extension WaveformView: WaveformViewStateDelegate {
    
    func didAddInterval(interval: WaveformViewState.WaveformViewInterval) {
        print("log: interval \(interval) was added")
    }
    
}

// MARK: -
// MARK: - Gesture Recognizer

fileprivate extension WaveformView {
    
    @IBAction private func didRecognizeDoubleTapGesture(_ gesture: UITapGestureRecognizer) {
        let x = gesture.location(in: waveformInternalView).x
        self.state = state.addInterval(around: x)
    }
    
}

// MARK: -
// MARK: - Set

extension WaveformView {
    
    func set(audioURL: URL) {
        waveformInternalView.set(audioURL: audioURL)
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension WaveformView {
    
    private func configure() {
        configureWaveformViewState()
        configureLayoutManager()
    }
    
    private func configureWaveformViewState() {
        state = WaveformViewState(delegate: self)
    }
    
    private func configureLayoutManager() {
        layoutManager = WaveformViewLayoutManager(view: self)
    }
    
}
