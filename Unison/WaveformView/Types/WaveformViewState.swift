//
//  WaveformViewState.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/14/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

struct WaveformViewState {
    
    // - Delegate
    private unowned let delegate: WaveformViewStateDelegate
    
    // - Aliases
    typealias WaveformViewInterval = (startX: CGFloat, endX: CGFloat)
    
    // - Data
    private let selectedIntervals: [WaveformViewInterval]
    
    // - Init
    init(delegate: WaveformViewStateDelegate, selectedIntervals: [WaveformViewInterval] = []) {
        self.delegate = delegate
        self.selectedIntervals = selectedIntervals
    }
    
}

// MARK: -
// MARK: - Interface

extension WaveformViewState {
    
    func addInterval(around x: CGFloat) -> WaveformViewState {
        let interval = (startX: x - 20, endX: x + 20) // - TODO:
        delegate.didAddInterval(interval: interval)
        return WaveformViewState(delegate: delegate, selectedIntervals: selectedIntervals + [interval])
    }
    
}
