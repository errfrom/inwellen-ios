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
    
    private weak var activeIntervalView: CommitSelectedIntervalView?
    
    // - Constants
    private struct Constant {
        static let intervalViewHorizontalPadding: CGFloat = 44
    }
    
    // - Lifecycle
    override func setupView() {
        super.setupView()
    }
    
}

// MARK: -
// MARK: - Interface

extension WaveformView: IWaveformView {

    func createAndDisplayOneSecondInterval(locationX: CGFloat) -> (intervalView: CommitSelectedIntervalView, endX: CGFloat)? {
        guard let locationXToSecondRatio = specifyIntervalsContextDirector?.locationXToSecondRatio else { return nil }
        
        let frame = prepareIntervalViewFrame(locationX, locationXToSecondRatio)
        let intervalView = CommitSelectedIntervalView(frame: frame)
        
        view.insertSubview(intervalView, belowSubview: contentView)
        self.activeIntervalView = intervalView
        return (intervalView, locationX + locationXToSecondRatio)
    }
    
    private func prepareIntervalViewFrame(_ locationX: CGFloat, _ locationXToSecondRatio: CGFloat) -> CGRect {
        let width = locationXToSecondRatio + Constant.intervalViewHorizontalPadding
        let x = interactiveArea.frame.minX + locationX - width / 2
        return CGRect(x: x, y: 0, width: width, height: self.bounds.height)
    }
    
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
            
            case .changed: // TODO: 
                guard let intervalView = activeIntervalView else { return }
                let translationX = gesture.translation(in: interactiveArea).x
                
                intervalView.bounds.size.width += translationX
                intervalView.center.x += translationX / 2
                gesture.setTranslation(.zero, in: interactiveArea)
            
            default:
                return
        }
    }
    
}
