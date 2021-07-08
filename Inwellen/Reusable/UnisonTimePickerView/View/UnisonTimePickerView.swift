//
//  InwellenTimePickerView.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/6/21.
//  Copyright © 2021 Inwellen. All rights reserved.
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
    var isCurrentPickerValueInitial: Bool = true
    
    var pickerValue: UnisonTimePickerValue! {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutManager?.layoutSubviews()
    }
    
}

// MARK: -
// MARK: - Set

extension UnisonTimePickerView {
    
    func set(pickerValue: UnisonTimePickerValue, isInitValue: Bool, delegate: UnisonTimePickerViewDelegate?) {
        self.pickerValue = pickerValue
        self.isCurrentPickerValueInitial = isInitValue
        self.delegate = delegate
        
        layoutManager?.pickerValueDidChange()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension UnisonTimePickerView {
    
    private func configure() {
        configureLayoutManager()
        configurePickerValue()
    }
    
    private func configureLayoutManager() {
        layoutManager = UnisonTimePickerViewLayoutManager(view: self)
    }
    
    private func configurePickerValue() {
        pickerValue = UnisonTimePickerValue()
    }
    
}
