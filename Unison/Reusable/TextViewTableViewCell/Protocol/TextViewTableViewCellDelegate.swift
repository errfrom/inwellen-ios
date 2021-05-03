//
//  TextViewTableViewCellDelegate.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Unison. All rights reserved.
//

protocol TextViewTableViewCellDelegate: class {
    func textViewDidUpdateHeight()
    func textViewWillBeginEditing(textViewCellType: TextViewCellType)
}
