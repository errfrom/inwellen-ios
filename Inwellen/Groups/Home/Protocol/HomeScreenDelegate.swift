//
//  HomeScreenDelegate.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 10.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

protocol HomeScreenDelegate: ProjectShelfViewDelegate {
    func didSelectProjectCell(projectPreview: ProjectPreviewModel)
    func layoutTopSectionView(isHidden: Bool)
}
