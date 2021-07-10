//
//  ProjectShelfViewItemModel.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 10.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import class UIKit.UIImage

struct ProjectShelfViewItemModel {
    let projectId: ID<ProjectPreviewModel>
    let image: UIImage?

    // - Init
    init(_ projectPreview: ProjectPreviewModel) {
        self.projectId = projectPreview.projectId
        self.image = projectPreview.coverImage
    }

}
