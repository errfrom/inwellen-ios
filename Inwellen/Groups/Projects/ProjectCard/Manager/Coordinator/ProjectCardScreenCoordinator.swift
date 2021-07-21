//
//  ProjectCardScreenCoordinator.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 12.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class ProjectCardScreenCoordinator {

    private unowned let vc: ProjectCardScreenViewController

    // - Init
    init(vc: ProjectCardScreenViewController) {
        self.vc = vc
    }

    func pop() {
        vc.navigationController?.popViewController(animated: true)
    }

}
