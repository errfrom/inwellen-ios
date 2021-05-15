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
    
    // - Manager
    private var layoutManager: CommitSelectedIntervalViewLayoutManager!
    
    // - Lifecycle
    override func setupView() {
        super.setupView()
        configure()
    }
    
}

// MARK: -
// MARK: - Interface

extension CommitSelectedIntervalView: ICommitSelectedIntervalView {
    
    
    
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
