//
//  ProjectShelfViewInterface.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 8.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import typealias UIKit.CGFloat

protocol IProjectShelfView: AnyObject {
    func set(models: [ProjectShelfViewItemModel], delegate: ProjectShelfViewDelegate?)
}
