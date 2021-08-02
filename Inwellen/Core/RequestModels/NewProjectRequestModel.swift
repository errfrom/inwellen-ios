//
//  NewProjectRequestModel.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 29.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import class UIKit.UIImage

struct NewProjectRequestModel: Equatable {
    var projectName: String?
    var projectDesc: String?
    var authorName: String?
    var coverImage: UIImage?
}
