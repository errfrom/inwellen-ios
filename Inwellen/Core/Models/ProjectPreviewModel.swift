//
//  ProjectPreviewModel.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 9.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import class UIKit.UIImage

struct ProjectPreviewModel {
    let projectId: ID<Self>
    let projectName: String
    let authorName: String
    let coverImage: UIImage?
}

extension ProjectPreviewModel: ProjectShelfViewItemModel {

    var image: UIImage? {
        return coverImage
    }

}
