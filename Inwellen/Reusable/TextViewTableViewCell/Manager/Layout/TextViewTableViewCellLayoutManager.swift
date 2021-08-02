//
//  TextViewTableViewCellLayoutManager.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class TextViewTableViewCellLayoutManager: NSObject {
    
    private unowned let cell: TextViewTableViewCell
    
    // - Constants
    private let MaxTextViewHeight: CGFloat = 240
    
    // - Data
    private var currentTextViewHeight: CGFloat = 24
    private var textViewSelectedRange: NSRange?
    private var shouldFixTextViewSelectedRange: Bool = false

    // - Computed
    private var numCharsExceedingLimit: Int {
        return max(0, cell.textView.attributedText.length - cell.config.charLimit)
    }

    private var textLengthExceedsLimit: Bool {
        return numCharsExceedingLimit > 0
    }
    
    // - Init
    init(cell: TextViewTableViewCell) {
        self.cell = cell
        super.init()
        configure()
    }
    
}

// MARK: -
// MARK: - UITextViewDelegate

extension TextViewTableViewCellLayoutManager: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text.isEmpty ? nil : textView.text
        cell.delegate?.textViewDidChange(text, configuration: cell.config)

        cell.setCharCounterLabel()
        highlightInputIfNeeded()
        setCharCounterLabelTextColor()
        layoutPlaceholderLabelIfNeeded()
        moveCharCounterLabelBelowTextViewContainerIfNeeded()
        adaptTextViewHeight(basedOn: textView.contentSize.height)
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if !textView.text.isEmpty { highlightInputIfNeeded(setHighlightingTo: true) }
        cell.delegate?.textViewWillBeginEditing(configuration: cell.config)
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        cell.delegate?.textViewDidEndEditing(configuration: cell.config)
        highlightInputIfNeeded(setHighlightingTo: false)
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        if let selectedRange = textViewSelectedRange, shouldFixTextViewSelectedRange {
            textView.selectedRange = selectedRange
        } else {
            textViewSelectedRange = textView.selectedRange
        }
    }
    
}

// MARK: -
// MARK: - Appearance

fileprivate extension TextViewTableViewCellLayoutManager {

    // swiftlint:disable:next discouraged_optional_boolean
    private func highlightInputIfNeeded(setHighlightingTo highlighting: Bool? = nil) {
        shouldFixTextViewSelectedRange = true
        let shouldHighlightInput = highlighting ?? !cell.textView.text.isEmpty
        highlightCharRangeWithinLimit(shouldHighlightInput)
        highlightCharRangeExceedingLimit()
        shouldFixTextViewSelectedRange = false

        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let strongSelf = self else { return }

            if strongSelf.textLengthExceedsLimit {
                strongSelf.cell.bottomBorderView.backgroundColor = AppColor.redSalsa
            } else {
                strongSelf.cell.bottomBorderView.backgroundColor =
                    shouldHighlightInput ? AppColor.absoluteZero : AppColor.platinum
            }
        }
    }

    private func highlightCharRangeWithinLimit(_ shouldHighlight: Bool) {
        let rangeLength = min(cell.config.charLimit, cell.textView.text.count)
        let range = NSRange(location: 0, length: rangeLength)
        let textColor = shouldHighlight ? AppColor.absoluteZero : AppColor.richBlack

        textViewSetTextColor(textColor, range: range)
    }

    private func highlightCharRangeExceedingLimit() {
        let charLimit = cell.config.charLimit
        let range = NSRange(location: charLimit, length: numCharsExceedingLimit)

        textViewSetTextColor(AppColor.redSalsa, range: range)
    }

    private func textViewSetTextColor(_ textColor: UIColor, range: NSRange) {
        guard let attrText = cell.textView.attributedText else { return }

        let mutAttrString = NSMutableAttributedString(attributedString: attrText)
        mutAttrString.addAttribute(.foregroundColor, value: textColor, range: range)

        cell.textView.attributedText = mutAttrString
    }

    private func setCharCounterLabelTextColor() {
        cell.charCounterLabel.textColor =
            textLengthExceedsLimit ? AppColor.redSalsa : AppColor.darkerPlatinum
    }

}

// MARK: -
// MARK: - Layout

fileprivate extension TextViewTableViewCellLayoutManager {
    
    private func adaptTextViewHeight(basedOn contentHeight: CGFloat) {
        guard contentHeight != currentTextViewHeight else { return }
        guard contentHeight <= MaxTextViewHeight else { return }
        
        self.currentTextViewHeight = contentHeight
        cell.textViewHeightConstraint.constant = max(cell.config.minTextViewHeight, contentHeight)
        cell.delegate?.textViewDidUpdateHeight()
    }
    
    private func layoutPlaceholderLabelIfNeeded() {
        cell.placeholderLabel.isHidden = !cell.textView.text.isEmpty
    }

    private func moveCharCounterLabelBelowTextViewContainerIfNeeded() {
        cell.charCounterLabel.layoutIfNeeded()

        let textViewMargin = cell.textViewContainerLeadingConstraint.constant
        let textWidth = cell.textView.text.width(usingFont: cell.config.textFont)
        let charCounterLabelMinX = cell.charCounterLabel.frame.minX
        let moveCharCounterLabelBelow = textViewMargin + textWidth >= charCounterLabelMinX - 16

        cell.charCounterLabelBottomConstraint.priority =
            .init(moveCharCounterLabelBelow ? 998 : 1000)
        cell.delegate?.textViewDidUpdateHeight()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension TextViewTableViewCellLayoutManager {
    
    private func configure() {
        configureTextView()
        configureCharCounterLabel()
        configureHintLabel()
    }
    
    private func configureTextView() {
        cell.textView.delegate = self
        cell.textView.tintColor = AppColor.silverChalice
        cell.textView.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
    }

    private func configureCharCounterLabel() {
        cell.charCounterLabel.addAttribute(.kern, value: 0.6)
    }

    private func configureHintLabel() {
        cell.hintLabel.isHidden = true
        cell.hintLabelTopConstraint.priority = .init(1000)
    }
    
}
