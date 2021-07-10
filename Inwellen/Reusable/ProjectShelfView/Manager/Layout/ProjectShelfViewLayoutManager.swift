//
//  ProjectShelfViewLayoutManager.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 3.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit
import SnapKit

final class ProjectShelfViewLayoutManager {

    private unowned let shelfView: ProjectShelfView

    // - Typealias
    typealias Item = ProjectShelfView.Item

    // - Helpers
    private var constants: ProjectShelfView.Constants {
        return shelfView.constants
    }

    // - Init
    init(view: ProjectShelfView) {
        self.shelfView = view
    }

}

// MARK: -
// MARK: - Layout: Build & Display Items

extension ProjectShelfViewLayoutManager {

    func buildShelfViewItem(model: ProjectShelfViewItemModel, _ previousItemView: UIView?) -> Item {
        let itemView = UIImageView()
        itemView.image = model.image
        itemView.isUserInteractionEnabled = true
        shelfView.insertSubview(itemView, at: 0)

        let shelfHeight = constants.shelfHeight
        let secondaryItemHeight = constants.secondaryItemHeight
        let itemSize = previousItemView == nil ? shelfHeight : secondaryItemHeight

        var itemConstraints: Item.Constraints = .init()

        itemView.snp.makeConstraints { make in
            itemConstraints.height = make.height.equalTo(itemSize).constraint
            make.width.equalTo(itemView.snp.height)
            make.bottom.equalToSuperview()

            if let prevItemView = previousItemView {
                let leadingMargin = itemSize * constants.overlapMultiplier
                itemConstraints.leading = make.leading.equalTo(prevItemView.snp.leading)
                    .offset(leadingMargin).constraint

            } else {
                itemConstraints.leading = make.leading.equalToSuperview().constraint
            }
        }

        return .init(model: model, view: itemView, constraints: itemConstraints)
    }

}

// MARK: -
// MARK: - Layout: Scrolling

extension ProjectShelfViewLayoutManager {

    func scroll(toItem targetItem: Item,
                withItemViewMinX itemViewMinX: CGFloat,
                completion: @escaping () -> Void) {

        let options: UIView.AnimationOptions = [.curveEaseIn]
        UIView.animate(withDuration: 0.5, dampingRatio: 0.7, options: options, animations: {
            [weak self] in guard let strongSelf = self else { return }
            strongSelf._scroll(toItem: targetItem, withItemViewMinX: itemViewMinX)
            strongSelf.shelfView.layoutIfNeeded()
        }, completion: { _ in completion() })
    }

    private func _scroll(toItem targetItem: Item, withItemViewMinX itemViewMinX: CGFloat) {
        targetItem.constraints.height?.update(offset: constants.shelfHeight)

        let headItem = shelfView.headItem
        let headItemLeadingMargin = shelfView.headItemLeadingMargin
        headItem?.constraints.leading?.update(offset: headItemLeadingMargin - itemViewMinX)
        headItem?.constraints.height?.update(offset: constants.secondaryItemHeight)

        updateConstraintsBeforeMovingHead(candidateItem: targetItem, true)
    }

}

// MARK: -
// MARK: - Layout: Update Constraints

extension ProjectShelfViewLayoutManager {

    func updateConstraintsBeforeMovingHead(candidateItem: Item?, _ shouldSnapHead: Bool = false) {
        let headItemLeadingMargin = shelfView.headItemLeadingMargin

        // Prevent auto layout conflicts by deactivating old constraints.
        candidateItem?.constraints.leading?.deactivate()
        shelfView.headItem?.constraints.leading?.deactivate()

        // Create a constraint: candidate.leading == container.leading + leadingMargin
        // where `leadingMargin` is calculated only if `shouldSnapHead` == false.
        //
        // `leadingMargin` is needed here to prevent items twitching while updating constraints.
        candidateItem?.view?.snp.makeConstraints { make in
            let leadingMargin = shouldSnapHead ? 0
                : calculateNewLeadingMargin(ofCandidateItem: candidateItem, headItemLeadingMargin)

            candidateItem?.constraints.leading =
                make.leading.equalToSuperview().offset(leadingMargin).constraint
        }

        // Create a constraint: head.leading == receiver.leading + leadingMargin
        shelfView.headItem?.view?.snp.makeConstraints { make in
            guard let receiverItemView = shelfView.tailItem?.view else { return }
            shelfView.headItem?.constraints.leading =
                make.leading.equalTo(receiverItemView.snp.leading)
                    .offset(constants.secondaryItemLeadingMargin).constraint
        }

        if headItemLeadingMargin > 0 { shelfView.shouldNormalizeItemsAppearance = true }
        adjustViewHierarchy(candidateItem: candidateItem)
    }
    
    private func calculateNewLeadingMargin(
        ofCandidateItem candidateItem: Item?,
        _ headItemLeadingMarginSnapshot: CGFloat) -> CGFloat {

        if headItemLeadingMarginSnapshot <= 0 {
            candidateItem?.view?.layoutIfNeeded()
            return candidateItem?.view?.frame.minX ?? 0
        } else {
            return -constants.secondaryItemVisibleWidth + headItemLeadingMarginSnapshot
        }
    }

    private func adjustViewHierarchy(candidateItem: Item?) {
        guard let headItemView = shelfView.headItem?.view,
              let candidateItemView = candidateItem?.view,
              let receiverItemView = shelfView.tailItem?.view else { return }

        shelfView.bringSubviewToFront(candidateItemView)
        shelfView.insertSubview(headItemView, belowSubview: receiverItemView)
    }

}

// MARK: -
// MARK: - Normalize Appearance

extension ProjectShelfViewLayoutManager {

    func normalizeItemsAppearance(animateHeadLeadingConstraint: Bool = false) {
        normalizeHeadItemAppearance(animateHeadLeadingConstraint)
        normalizeSecondaryItemAppearance(shelfView.nextItem)
        normalizeSecondaryItemAppearance(shelfView.tailItem)
    }

    private func normalizeHeadItemAppearance(_ animateHeadLeadingConstraint: Bool) {
        shelfView.headItem?.view?.alpha = 1
        shelfView.headItem?.constraints.height?.update(offset: constants.shelfHeight)

        if animateHeadLeadingConstraint {
            let animationOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseOut]

            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0, options: animationOptions) { [weak self] in

                guard let strongSelf = self else { return }
                strongSelf.shelfView.headItem?.constraints.leading?.update(offset: 0)
                strongSelf.shelfView.layoutIfNeeded()
            }
        } else {
            shelfView.headItem?.constraints.leading?.update(offset: 0)
        }
    }

    private func normalizeSecondaryItemAppearance(_ secondaryItem: Item?) {
        secondaryItem?.view?.alpha = 1
        secondaryItem?.constraints.height?.update(offset: constants.secondaryItemHeight)
    }

}

// MARK: -
// MARK: - Update Appearance

extension ProjectShelfViewLayoutManager {

    func updateItemsAppearanceWhileDragging() {
        if shelfView.headItemLeadingMargin <= 0 {
            updateHeadItemAppearanceWhileDragging(shouldUpdateAlpha: true)
            updateNextItemAppearanceWhileDragging()
            updateTailItemAppearanceWhileDragging()
        } else {
            updateHeadItemAppearanceWhileDragging(shouldUpdateAlpha: false)
            updateTailItemAppearanceWhileDragging()
        }
    }

    private func updateHeadItemAppearanceWhileDragging(shouldUpdateAlpha: Bool) {
        let headItemLeadingMargin = abs(shelfView.headItemLeadingMargin)
        let deltaMultiplier = headItemLeadingMargin / constants.secondaryItemVisibleWidth
        let newHeight = constants.shelfHeight - deltaMultiplier * constants.secondaryItemTopMargin
        if shouldUpdateAlpha { shelfView.headItem?.view?.alpha = 1 - deltaMultiplier }
        shelfView.headItem?.constraints.height?.update(offset: newHeight)
    }

    private func updateNextItemAppearanceWhileDragging() {
        let headItemLeadingMargin = abs(shelfView.headItemLeadingMargin)
        let deltaMultiplier = 1 - headItemLeadingMargin / constants.secondaryItemVisibleWidth
        let newHeight = constants.shelfHeight - deltaMultiplier * constants.secondaryItemTopMargin
        shelfView.nextItem?.constraints.height?.update(offset: newHeight)
    }

    private func updateTailItemAppearanceWhileDragging() {
        let moveHeadBackwardTranslationThreshold = constants.moveHeadBackwardTranslationThreshold
        let headItemLeadingMargin = shelfView.headItemLeadingMargin

        let tailItemAlpha = 1 - headItemLeadingMargin / moveHeadBackwardTranslationThreshold
        shelfView.tailItem?.view?.alpha = tailItemAlpha
    }

}

// MARK: -
// MARK: - Appearance: Post-Animation

extension ProjectShelfViewLayoutManager {

    func animateTailItemAlpha() {
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.shelfView.tailItem?.view?.alpha = 1
        }
    }

}
