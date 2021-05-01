//
//  CreateCommitScreenCoordinator.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CreateCommitScreenCoordinator {
    
    private unowned let vc: CreateCommitScreenViewController
    
    // - Init
    init(vc: CreateCommitScreenViewController) {
        self.vc = vc
    }
    
    func dismiss() {
        vc.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
