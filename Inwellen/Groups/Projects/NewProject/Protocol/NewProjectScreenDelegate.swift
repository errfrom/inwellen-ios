//
//  NewProjectScreenDelegate.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 24.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

protocol NewProjectScreenDelegate: TextViewCellDelegate {
    var requestModel: NewProjectRequestModel { get }
}
