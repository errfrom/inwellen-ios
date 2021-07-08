//
//  StoryboardEnum.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 9/13/20.
//  Copyright © 2020 Inwellen. All rights reserved.
//

import UIKit

enum Storyboard: String {
    
    // - Commit
    case createCommit = "CreateCommit"
    case chooseProject = "ChooseProject"
    case specifyIntervals = "SpecifyIntervals"
    
}

extension Storyboard {
    
    var filename: String {
        return rawValue
    }
    
    var viewController: UIViewController {
        return UIStoryboard(storyboard: self).instantiateInitialViewController()!
    }
    
}
