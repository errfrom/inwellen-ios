//
//  UnisonTimePickerViewLayoutManager.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/6/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class UnisonTimePickerViewLayoutManager: NSObject {
    
    private unowned let view: UnisonTimePickerView
    
    // - Init
    init(view: UnisonTimePickerView) {
        self.view = view
        super.init()
        configure()
    }
    
}

// MARK: -
// MARK: - Event

extension UnisonTimePickerViewLayoutManager {
    
    func pickerValueDidChange() {
        view.timeLabel.text = view.pickerValue.timeLabelText
        view.textField.text = view.pickerValue.textFieldInput
    }
    
}

// MARK: -
// MARK: - UITextFieldDelegate

extension UnisonTimePickerViewLayoutManager: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layout(editingMode: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        layout(editingMode: false)
        view.pickerValue = UnisonTimePickerValue.init(fromTimeLabelString: textField.text ?? "")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        guard text.count <= 4 else { return false }
        
        let formattedText = UnisonTimePickerInputFormatter.formatInput(string: text)
        view.timeLabel.text = formattedText
        return true
    }

}

// MARK: -
// MARK: - Layout

fileprivate extension UnisonTimePickerViewLayoutManager {
    
    private func layout(editingMode: Bool) {
        view.timeLabel.textColor = editingMode ? AppColor.accentOrangeColor : AppColor.accentBlueColor
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension UnisonTimePickerViewLayoutManager {
    
    private func configure() {
        configureTextField()
        configureTimeLabel()
    }
    
    private func configureTextField() {
        view.textField.delegate = self
    }
    
    private func configureTimeLabel() {
        view.timeLabel.addAttribute(.kern, value: 1)
    }
    
}
