//
//  UnisonTimePickerViewDelegate.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/6/21.
//  Copyright © 2021 Unison. All rights reserved.
//

protocol UnisonTimePickerViewDelegate: class {
    func timePickerValueDidChange(toValue pickerValue: UnisonTimePickerValue)
}
