//
//  ChooseProjectScreenCoordinator.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class ChooseProjectScreenCoordinator {
    
    private unowned let vc: ChooseProjectScreenViewController
    
    // - Init
    init(vc: ChooseProjectScreenViewController) {
        self.vc = vc
    }
    
    func dismiss() {
        vc.dismiss(animated: true, completion: nil)
    }
    
}
