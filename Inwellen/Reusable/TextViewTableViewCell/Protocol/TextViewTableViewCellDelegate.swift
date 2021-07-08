//
//  TextViewTableViewCellDelegate.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

protocol TextViewTableViewCellDelegate: class {
    func textViewDidUpdateHeight()
    func textViewWillBeginEditing(textViewCellType: TextViewCellType)
}
