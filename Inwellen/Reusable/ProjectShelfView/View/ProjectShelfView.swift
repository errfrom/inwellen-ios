//
//  ProjectShelfView.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 3.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class ProjectShelfView: UIView {

    // - Delegate
    private weak var delegate: ProjectShelfViewDelegate?

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

    func set(models: [ProjectShelfViewItemModel], delegate: ProjectShelfViewDelegate?) {
        self.delegate = delegate

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
            handleShelfViewTapGestureEndedState(gesture)
        }
    }

}

// MARK: -
// MARK: - Handle ShelfViewPanGesture

fileprivate extension ProjectShelfView {

    private func handleShelfViewPanGestureChangedState(_ gesture: UIPanGestureRecognizer) {
        let translationX = gesture.translation(in: self).x
        gesture.setTranslation(.zero, in: self)

        let headItemLeadingMargin = self.headItemLeadingMargin + translationX / 2
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
        delegate?.projectShelf(didSelectProjectWithId: headItem?.modelId)
    }

    private func normalizeItemsAppearanceIfNeeded(_ headItemLeadingMargin: CGFloat) {
        if headItemLeadingMargin >= 0 && shouldNormalizeItemsAppearance {
            layoutManager.normalizeItemsAppearance()
            shouldNormalizeItemsAppearance = false
        }
    }

}

// MARK: -
// MARK: - Handle ShelfViewTapGesture

fileprivate extension ProjectShelfView {

    private func handleShelfViewTapGestureEndedState(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        guard hitTest(location, with: nil) !== self else { return }

        let stepsToTargetItem = stepsToItemView(thatContainsPoint: location.x)
        guard stepsToTargetItem > 0 else { return }
        guard let targetItem = items.value(atDistance: stepsToTargetItem) else { return }

        let itemViewMinX = constants.secondaryItemVisibleWidth * CGFloat(stepsToTargetItem)

        layoutManager.scroll(toItem: targetItem, withItemViewMinX: itemViewMinX) { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.items.moveHeadForward(steps: stepsToTargetItem)
            strongSelf.delegate?.projectShelf(didSelectProjectWithId: strongSelf.headItem?.modelId)
        }
    }

    // x = sh + (vw - tm) + (n - 2)vw
    private func stepsToItemView(thatContainsPoint x: CGFloat) -> Int {
        let sh = constants.shelfHeight
        let vw = constants.secondaryItemVisibleWidth
        let tm = constants.secondaryItemTopMargin
        return Int((x - sh + vw + tm) / vw)
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
