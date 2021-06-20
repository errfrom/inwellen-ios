//
//  CommitSelectedIntervalView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/14/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CommitSelectedIntervalView: ReusableBaseView, ISpecifyIntervalsContextComponent {
    
    // - Mediator
    var specifyIntervalsContextDirector: ISpecifyIntervalsContextMediator?
    
    // - UI
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    // - Constraints
    @IBOutlet weak var visibleViewWidthConstraint: NSLayoutConstraint!
    
    // - Manager
    private var layoutManager: CommitSelectedIntervalViewLayoutManager!
    
    // - Constant
    private struct Constant {
        static let minIntervalViewWidth = 88
        
    }
    
    // - Data
    private var timeInterval: TimeInterval?
    
    // - Init
    /* required init(mediator: ISpecifyIntervalsContextMediator, timeInterval: TimeInterval) {
        let visibleViewMinX = CGFloat(timeInterval.startTime) * mediator.locationXToSecondRatio
        let visibleViewWidth = visibleViewMinX + CGFloat(timeInterval.endTime) * mediator.locationXToSecondRatio
        self.visibleViewWidthConstraint.constant = visibleViewWidth
        
        configure()
    } */

    // - Lifecycle
    override func setupView() {
        super.setupView()
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}

// MARK: -
// MARK: - Interface

extension CommitSelectedIntervalView: ICommitSelectedIntervalView {
    
    func setInitially(contextDirector: ISpecifyIntervalsContextMediator, timeInterval: TimeInterval) {
        self.specifyIntervalsContextDirector = contextDirector
        self.timeInterval = timeInterval
        setVisibleViewWidthConstraint()
        setTimeLabels()
    }
    
    func updateTimeInterval(newStartTime: UnisonTimePickerValue) {
        
    }
    
    func updateTimeInterval(newEndTime: UnisonTimePickerValue) {
        
    }
    
    private func setVisibleViewWidthConstraint() {
        guard let contextDirector = specifyIntervalsContextDirector else { return }
        guard let timeInterval = timeInterval else { return }
        
        let visibleViewMinX = CGFloat(timeInterval.startTime.base) * contextDirector.locationXToSecondRatio
        let visibleViewWidth = CGFloat(timeInterval.endTime.base) * contextDirector.locationXToSecondRatio - visibleViewMinX
        self.visibleViewWidthConstraint.constant = visibleViewWidth
    }
    
    private func setTimeLabels() {
        guard let timeInterval = timeInterval else { return }
        self.startTimeLabel.text = timeInterval.startTime.timeLabelText
        self.endTimeLabel.text = timeInterval.endTime.timeLabelText
    }
    
}

// MARK: -
// MARK: - Action

fileprivate extension CommitSelectedIntervalView {
    
    @IBAction private func didRecognizeLeftEdgePanGesture(_ gesture: UIPanGestureRecognizer) {
        handleEdgeViewPanGesture(gesture)
    }
    
    @IBAction private func didRecognizeRightEdgePanGesture(_ gesture: UIPanGestureRecognizer) {
        handleEdgeViewPanGesture(gesture)
    }
    
    private func handleEdgeViewPanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let edgeView = gesture.view else { return }
        
        let translationX = gesture.translation(in: contentView).x
        requestIntervalLocationChange(edgeView: edgeView, translationX: translationX)
        gesture.setTranslation(.zero, in: contentView)
    }
        
    private func requestIntervalLocationChange(edgeView view: UIView, translationX: CGFloat) {
        var event: SpecifyIntervalsContextEvent
        event = .intervalLocationChangeRequest(dStartX: view.tag == 0 ? translationX : nil, dEndX: view.tag == 1 ? translationX : nil)
        specifyIntervalsContextDirector?.notify(sender: self, event: event)
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CommitSelectedIntervalView {
    
    private func configure() {
        configureLayoutManager()
    }
    
    private func configureLayoutManager() {
        layoutManager = CommitSelectedIntervalViewLayoutManager(view: self)
    }
    
}
