//
//  WaveformView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/11/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit
import SnapKit

class WaveformView: ReusableBaseView, ISpecifyIntervalsContextComponent {
    
    // - Mediator
    var specifyIntervalsContextDirector: ISpecifyIntervalsContextMediator?
    
    // - UI
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var interactiveArea: UIView!
    
    private weak var activeIntervalView: CommitSelectedIntervalView?
    
    // - Manager
    private var layoutManager: WaveformViewLayoutManager!
    
    // - Constants
    private struct Constant {
        static let intervalViewHorizontalPadding: CGFloat = 44
    }
    
    // - Lifecycle
    override func setupView() {
        super.setupView()
        configure()
        
        // let frame = CGRect(x: 120, y: 0, width: 88, height: bounds.height)
        // let intervalView = CommitSelectedIntervalView()
        // view.insertSubview(intervalView, belowSubview: contentView)
        // activeIntervalView = intervalView
        // intervalView.snp.makeConstraints { make in
        //     make.leading.equalTo(120)
        //    make.top.height.equalToSuperview()
        // }
        // intervalView.visibleViewWidthConstraint.constant = 60
        // view.insertSubview(intervalView, belowSubview: contentView)
        // intervalView.visibleViewWidthConstraint.constant = 5
        // intervalView.setNeedsLayout()
    }
    
}

// MARK: -
// MARK: - Interface

extension WaveformView: IWaveformView {

    func createAndDisplayIntervalView(timeInterval: TimeInterval) -> CommitSelectedIntervalView? {
        guard let contextDirector = specifyIntervalsContextDirector else { return nil }
        
        let intervalView = CommitSelectedIntervalView()
        intervalView.setInitially(contextDirector: contextDirector, timeInterval: timeInterval)
        layoutManager?.insert(intervalView: intervalView, intervalViewMinX: 80)
        return intervalView
        // guard let locationXToSecondRatio = specifyIntervalsContextDirector?.locationXToSecondRatio else { return nil }
        
        // let frame = prepareIntervalViewFrame(locationX, locationXToSecondRatio)
        // let intervalView = CommitSelectedIntervalView(frame: frame)
        
        // view.insertSubview(intervalView, belowSubview: contentView)
        // self.activeIntervalView = intervalView
        // return (intervalView, locationX + locationXToSecondRatio)
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
            
            case .changed:
                return
                // let translationX = gesture.translation(in: interactiveArea).x
                // activeIntervalView?.visibleViewWidthConstraint.constant += translationX
                // print("DISTANCE BETWEEN LABELS: \(activeIntervalView!.endTimeLabel.frame.minX - activeIntervalView!.startTimeLabel.frame.maxX)")
                // gesture.setTranslation(.zero, in: interactiveArea)
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

// MARK: -
// MARK: - Configure

fileprivate extension WaveformView {
    
    private func configure() {
        configureLayoutManager()
    }
    
    private func configureLayoutManager() {
        layoutManager = WaveformViewLayoutManager(view: self)
    }
    
}
