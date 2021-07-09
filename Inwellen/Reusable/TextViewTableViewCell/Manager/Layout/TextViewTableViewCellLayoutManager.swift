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
    private let MaxTextViewHeight: CGFloat = 160
    
    // - Data
    private var currentTextViewHeight: CGFloat = 0
    private var isInputHighlighted: Bool = false
    
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
        layoutPlaceholderLabelIfNeeded()
        highlightInputIfNeeded()
        adaptTextViewHeight(basedOn: textView.contentSize.height)
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if !textView.text.isEmpty { highlightInputIfNeeded(setHighlightingTo: true) }
        cell.delegate?.textViewWillBeginEditing(textViewCellType: cell.config)
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        highlightInputIfNeeded(setHighlightingTo: false)
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

    // swiftlint:disable:next discouraged_optional_boolean
    private func highlightInputIfNeeded(setHighlightingTo highlighting: Bool? = nil) {
        let shouldHighlightInput = highlighting ?? !cell.textView.text.isEmpty
        guard shouldHighlightInput != isInputHighlighted else { return }
        self.isInputHighlighted = shouldHighlightInput
        
        cell.textView.textColor = shouldHighlightInput ? AppColor.absoluteZero : AppColor.richBlack
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.cell.bottomBorderView.backgroundColor =
                shouldHighlightInput ? AppColor.absoluteZero : AppColor.platinum
        }
    }
    
}

// MARK: -
// MARK: - Configure

extension TextViewTableViewCellLayoutManager {
    
    private func configure() {
        configureTextView()
    }
    
    private func configureTextView() {
        cell.textView.delegate = self
        cell.textView.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
    }
    
    func configureTextViewFont() {
        cell.textView.font = cell.config.textFont
    }
    
    func configurePlaceholderLabel() {
        cell.placeholderLabel.text = cell.config.placeholderText
    }
    
}
