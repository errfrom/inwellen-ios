//
//  InwellenTimePickerViewDelegate.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/6/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

protocol UnisonTimePickerViewDelegate: class {
    func timePickerValueDidChange(toValue pickerValue: UnisonTimePickerValue)
}
