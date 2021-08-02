//
//  HomeScreenCoordinator.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 12.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class HomeScreenCoordinator {

    private unowned let vc: HomeScreenViewController

    // - Init
    init(vc: HomeScreenViewController) {
        self.vc = vc
    }

    func moveToProjectCardScreen() {
        let projectCardScreen = Storyboard.projectCard.viewController
        vc.navigationController?.pushViewController(projectCardScreen, animated: true)
    }

    func moveToNewProjectScreen() {
        let newProjectScreen = Storyboard.newProject.viewController
        vc.navigationController?.pushViewController(newProjectScreen, animated: true)
    }

}
