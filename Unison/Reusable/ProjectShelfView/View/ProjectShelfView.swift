//
//  ProjectShelfView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 3.07.21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

final class ProjectShelfView: UIView {

    // - Manager
    private var layoutManager: ProjectShelfViewLayoutManager!

    // - Data
    private(set) var items: CircularDoublyLinkedList<Item> = .init()
    private(set) var constants: Constants!
    var shouldNormalizeItemsAppearance: Bool = false

    // - Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

}

// MARK: -
// MARK: - Interface

extension ProjectShelfView: IProjectShelfView {

    func set(models: [ProjectShelfViewItemModel]) {
        var previousItemView: UIView?
        models.forEach { model in
            let item = layoutManager.buildShelfViewItem(model: model, previousItemView)
            previousItemView = item.view
            items.append(item)
        }
    }

}

// MARK: -
// MARK: - Gesture

fileprivate extension ProjectShelfView {

    @objc private func didRecognizeShelfViewPanGesture(_ gesture: UIPanGestureRecognizer) {
        if case .changed = gesture.state {
            handleShelfViewPanGestureChangedState(gesture)
        } else if case .ended = gesture.state {
            handleShelfViewPanGestureEndedState(gesture)
        }
    }

    @objc private func didRecognizeShelfViewTapGesture(_ gesture: UITapGestureRecognizer) {
        if case .ended = gesture.state {
            let location = gesture.location(in: self)
            guard hitTest(location, with: nil) !== self else { return }
        }
    }

}

// MARK: -
// MARK: - Handle ShelfViewPanGesture

fileprivate extension ProjectShelfView {

    private func handleShelfViewPanGestureChangedState(_ gesture: UIPanGestureRecognizer) {
        let translationX = gesture.translation(in: self).x
        gesture.setTranslation(.zero, in: self)

        let headItemLeadingMargin = headItemLeadingMargin + translationX
        headItem?.constraints.leading?.update(offset: headItemLeadingMargin)

        normalizeItemsAppearanceIfNeeded(headItemLeadingMargin)
        layoutManager.updateItemsAppearanceWhileDragging()

        if headItemLeadingMargin < constants.moveHeadForwardTranslationThreshold {
            layoutManager.updateConstraintsBeforeMovingHead(candidateItem: nextItem)
            items.moveHeadForward()
            layoutManager.animateTailItemAlpha()
            layoutManager.normalizeItemsAppearance()

        } else if headItemLeadingMargin > constants.moveHeadBackwardTranslationThreshold {
            layoutManager.updateConstraintsBeforeMovingHead(candidateItem: tailItem)
            items.moveHeadBackward()
        }
    }

    private func handleShelfViewPanGestureEndedState(_ gesture: UIPanGestureRecognizer) {
        if headItemLeadingMargin < constants.makeNextItemHeadTranslationThreshold {
            layoutManager.updateConstraintsBeforeMovingHead(candidateItem: nextItem, false)
            items.moveHeadForward()
            layoutManager.animateTailItemAlpha()
            layoutIfNeeded()
        }
        layoutManager.normalizeItemsAppearance(animateHeadLeadingConstraint: true)
    }

    private func normalizeItemsAppearanceIfNeeded(_ headItemLeadingMargin: CGFloat) {
        if headItemLeadingMargin >= 0 && shouldNormalizeItemsAppearance {
            layoutManager.normalizeItemsAppearance()
            shouldNormalizeItemsAppearance = false
        }
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension ProjectShelfView {

    private func configure() {
        calculateConstants()
        configureLayoutManager()
        configureShelfViewPanGestureRecognizer()
        configureShelfViewTapGestureRecognizer()
    }

    private func calculateConstants() {
        constants = Constants(shelfHeight: bounds.height)
    }

    private func configureLayoutManager() {
        layoutManager = ProjectShelfViewLayoutManager(view: self)
    }

    private func configureShelfViewPanGestureRecognizer() {
        let panGestureAction = #selector(didRecognizeShelfViewPanGesture(_:))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: panGestureAction)
        self.addGestureRecognizer(panGestureRecognizer)
    }

    private func configureShelfViewTapGestureRecognizer() {
        let tapGestureAction = #selector(didRecognizeShelfViewTapGesture(_:))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: tapGestureAction)
        self.addGestureRecognizer(tapGestureRecognizer)
    }

}
