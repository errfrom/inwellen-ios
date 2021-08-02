//
//  TextViewTableViewCell.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {

    // - Delegate
    private(set) weak var delegate: TextViewCellDelegate?
    
    // - UI
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomPaddingView: UIView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var bottomBorderView: UIView!
    @IBOutlet weak var charCounterLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    
    // - Constraints
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewContainerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var charCounterLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var hintLabelTopConstraint: NSLayoutConstraint!

    // - Manager
    private var layoutManager: TextViewTableViewCellLayoutManager?
    
    // - Data
    private(set) var config: TextViewCellConfiguration!
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
}

// MARK: -
// MARK: - Interface

extension TextViewTableViewCell: ITextViewCell {

    func set(_ configuration: TextViewCellConfiguration, delegate: TextViewCellDelegate?) {
        self.config = configuration
        self.delegate = delegate
        setTextViewFont()
        setPlaceholderLabel()
        setCharCounterLabel()
        setHintLabel()
    }

    func setCharCounterLabel() {
        charCounterLabel.text = "\(textView.text.count) / \(config.charLimit)"
    }

    private func setTextViewFont() {
        textView.font = config.textFont
    }

    private func setPlaceholderLabel() {
        placeholderLabel.text = config.placeholderText
    }

    private func setHintLabel() {
        hintLabel.text = config.hintText
        hintLabel.isHidden = config.hintText == nil
        hintLabelTopConstraint.priority = .init(config.hintText != nil ? 1000 : 996)
    }
    
}

// MARK: -
// MARK: - Gesture

fileprivate extension TextViewTableViewCell {

    @IBAction private func didTapTextViewBottomPaddingView(_ gesture: UITapGestureRecognizer) {
        if !textView.isFirstResponder {
            textView.becomeFirstResponder()
        }
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension TextViewTableViewCell {
    
    private func configure() {
        configureLayoutManager()
        configureTextViewBottomPaddingViewTapGesture()
    }
    
    private func configureLayoutManager() {
        layoutManager = TextViewTableViewCellLayoutManager(cell: self)
    }

    private func configureTextViewBottomPaddingViewTapGesture() {
        let tapGestureAction = #selector(didTapTextViewBottomPaddingView(_:))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: tapGestureAction)
        textViewBottomPaddingView.addGestureRecognizer(tapGestureRecognizer)
    }

}
