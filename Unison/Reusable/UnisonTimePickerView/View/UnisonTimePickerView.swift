//
//  UnisonTimePickerView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/6/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class UnisonTimePickerView: ReusableBaseView {
    
    @objc(UnisonTimePickerTextField)
    class UnisonTimePickerTextField: UITextField {
        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            return false
        }
    }
    
    // - Delegate
    private weak var delegate: UnisonTimePickerViewDelegate?
    
    // - UI
    @IBOutlet weak var textField: UnisonTimePickerTextField!
    @IBOutlet weak var timeLabel: UILabel!
    
    // - Manager
    private var layoutManager: UnisonTimePickerViewLayoutManager?
    
    // - Data
    var pickerValue = UnisonTimePickerValue() {
        didSet {
            layoutManager?.pickerValueDidChange()
            delegate?.timePickerValueDidChange(toValue: pickerValue)
        }
    }
    
    // - Lifecycle
    override func setupView() {
        super.setupView()
        configure()
    }
    
}

// MARK: -
// MARK: - Set

extension UnisonTimePickerView {
    
    func set(initPickerValue: UnisonTimePickerValue, delegate: UnisonTimePickerViewDelegate?) {
        self.pickerValue = initPickerValue
        self.delegate = delegate
        layoutManager?.pickerValueDidChange()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension UnisonTimePickerView {
    
    private func configure() {
        configureLayoutManager()
    }
    
    private func configureLayoutManager() {
        layoutManager = UnisonTimePickerViewLayoutManager(view: self)
    }
    
}
