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
    private(set) weak var delegate: TextViewTableViewCellDelegate?
    
    // - UI
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var bottomBorderView: UIView!
    
    // - Constraints
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
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
// MARK: - Set

extension TextViewTableViewCell {
    
    func set(withConfig config: TextViewCellConfiguration, delegate: TextViewTableViewCellDelegate?) {
        self.config = config
        self.delegate = delegate
        
        layoutManager?.configureTextViewFont()
        layoutManager?.configurePlaceholderLabel()
    }
    
    func makeTextViewFirstResponder() {
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
    }
    
    private func configureLayoutManager() {
        layoutManager = TextViewTableViewCellLayoutManager(cell: self)
    }
    
}
