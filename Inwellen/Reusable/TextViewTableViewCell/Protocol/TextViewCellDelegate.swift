//
//  TextViewCellDelegate.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

protocol TextViewCellDelegate: AnyObject {
    func textViewDidChange(_ text: String?, configuration: TextViewCellConfiguration)
    func textViewWillBeginEditing(configuration: TextViewCellConfiguration)
    func textViewDidEndEditing(configuration: TextViewCellConfiguration)
    func textViewDidUpdateHeight()
}

extension TextViewCellDelegate {
    func textViewDidEndEditing(configuration: TextViewCellConfiguration) {}
}
