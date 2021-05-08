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
    
    // - Data
    private var inEditingMode: Bool = false {
        didSet {
            view.setNeedsLayout()
            adjustTimeLabelAppearance()
        }
    }
    
    private var contentViewShadowColor: UIColor {
        if inEditingMode {
            return AppColor.accentOrangeColor.withAlphaComponent(0.2)
        } else {
            return AppColor.darkBlueColor.withAlphaComponent(0.08)
        }
    }
    
    // - Init
    init(view: UnisonTimePickerView) {
        self.view = view
        super.init()
        configure()
    }
    
    // - Lifecycle
    func layoutSubviews() {
        contentViewApplyShadow()
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
        self.inEditingMode = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.inEditingMode = false
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
// MARK: - Appearance

fileprivate extension UnisonTimePickerViewLayoutManager {
    
    private func adjustTimeLabelAppearance() {
        let animationOptions: UIView.AnimationOptions = [.transitionCrossDissolve, .curveEaseOut]
        UIView.transition(with: view.timeLabel, duration: 0.25, options: animationOptions, animations: { [weak self] in
            guard let strongSelf = self else { return }
            
            let textColor = strongSelf.inEditingMode ? AppColor.accentOrangeColor : AppColor.accentBlueColor
            strongSelf.view.timeLabel.textColor = textColor
        })
    }
    
}

// MARK: -
// MARK: - Shadow

fileprivate extension UnisonTimePickerViewLayoutManager {

    private func contentViewApplyShadow() {
        let shadowOffset = CGSize(width: 0, height: 2)
        view.applyShadow(color: contentViewShadowColor, offset: shadowOffset, blur: 10)
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
