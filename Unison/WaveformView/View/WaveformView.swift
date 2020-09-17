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
        
        let url = Bundle.main.url(forResource: "dom", withExtension: "mp3")!
        set(audioURL: url)
    }
    
}

// MARK: -
// MARK: - WaveformIntervalViewDelegate

extension WaveformView: WaveformIntervalViewDelegate {
    
    func shouldSelectInterval(intervalID: Int) {
        state.selectInterval(id: intervalID)
    }
    
}

// MARK: -
// MARK: - Gesture Recognizer

fileprivate extension WaveformView {
    
    @IBAction private func didRecognizeDoubleTapGesture(_ gesture: UITapGestureRecognizer) {
        let x = gesture.location(in: waveformInternalView).x
        state.addInterval(centerX: x) { [weak self] intervalModel in
            guard let self = self else { return }
            let intervalView = intervalModel.view
            intervalView.set(intervalID: intervalModel.id, delegate: self)
            self.waveformInternalView.insertSubview(intervalView, at: 1)
        }
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
        state = WaveformViewState(waveformViewWidth: bounds.width)
    }
    
    private func configureLayoutManager() {
        layoutManager = WaveformViewLayoutManager(view: self)
    }
    
}
