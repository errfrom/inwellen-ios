//
//  CreateCommitScreenCoordinator.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class CreateCommitScreenCoordinator {
    
    private unowned let vc: CreateCommitScreenViewController
    
    // - Init
    init(vc: CreateCommitScreenViewController) {
        self.vc = vc
    }
    
    func dismiss() {
        vc.dismiss(animated: true, completion: nil)
    }
    
    func moveToChooseProject() {
        let chooseProject_vc = Storyboard.chooseProject.viewController as! ChooseProjectScreenViewController
        vc.navigationController?.present(chooseProject_vc, animated: true, completion: nil)
    }
    
}
