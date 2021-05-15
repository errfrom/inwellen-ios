//
//  SpecifyIntervalsContextMediator.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/15/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class SpecifyIntervalsContextMediator {
    
    // - Components
    private unowned var waveformView: IWaveformView
    
    // - Init
    init(waveformView: IWaveformView) {
        self.waveformView = waveformView
        configure()
    }
    
}

// MARK: -
// MARK: - Interface

extension SpecifyIntervalsContextMediator: ISpecifyIntervalsContextMediator {
    
    func notify(sender: ISpecifyIntervalsContextComponent, event: SpecifyIntervalsContextEvent) {
        switch event {
            case .addIntervalRequest(let locationX):
                guard let waveformView = sender as? IWaveformView else { return }
                handleAddIntervalRequest(sender: waveformView, locationX: locationX)
            
            case .intervalLocationChangeRequest(let dStartX, let dEndX):
                guard let intervalView = sender as? ICommitSelectedIntervalView else { return }
                handleIntervalLocationChangeRequest(sender: intervalView, dStartX, dEndX)
        }
    }
    
}

// MARK: -
// MARK: - Handle Events

fileprivate extension SpecifyIntervalsContextMediator {
    
    private func handleAddIntervalRequest(sender: IWaveformView, locationX: CGFloat) {
        log.debug("mediator -> got add interval request, locationX: \(locationX)")
    }
    
    private func handleIntervalLocationChangeRequest(sender: ICommitSelectedIntervalView, _ dStartX: CGFloat?, _ dEndX: CGFloat?) {
        log.debug("mediator -> got interval location change request, dStartX: \(dStartX.debugDescription), dEndX: \(dEndX.debugDescription)")
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension SpecifyIntervalsContextMediator {
    
    private func configure() {
        configureWaveformView()
    }
    
    private func configureWaveformView() {
        (waveformView as? WaveformView)?.specifyIntervalsContextDirector = self
    }
    
}
