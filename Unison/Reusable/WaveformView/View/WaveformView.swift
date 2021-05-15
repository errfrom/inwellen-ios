//
//  WaveformView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/11/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class WaveformView: ReusableBaseView, ISpecifyIntervalsContextComponent {
    
    // - Mediator
    var specifyIntervalsContextDirector: ISpecifyIntervalsContextMediator?
    
    // - UI
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var interactiveArea: UIView!
    
    // - Lifecycle
    override func setupView() {
        super.setupView()
        
        let interval = CommitSelectedIntervalView(frame: CGRect(x: 60, y: 0, width: 70 + 44, height: self.bounds.height))
        view.insertSubview(interval, belowSubview: contentView)
    }
    
}

// MARK: -
// MARK: - Interface

extension WaveformView: IWaveformView {
    
    
    
}

// MARK: -
// MARK: - Action

fileprivate extension WaveformView {
    
    @IBAction private func didRecognizeInteractiveAreaPanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            case .began:
                let locationX = gesture.location(in: interactiveArea).x
                let addIntervalRequest: SpecifyIntervalsContextEvent = .addIntervalRequest(locationX: locationX)
                specifyIntervalsContextDirector?.notify(sender: self, event: addIntervalRequest)
            
            case .changed:
                return 
            
            default:
                return
        }
    }
    
}
