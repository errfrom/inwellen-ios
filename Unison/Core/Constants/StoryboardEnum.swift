//
//  StoryboardEnum.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/13/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

enum Storyboard: String {
    
    // - Commit
    case createCommit = "CreateCommit"
    case chooseProject = "ChooseProject"
    
}

extension Storyboard {
    
    var filename: String {
        return rawValue
    }
    
    var viewController: UIViewController {
        return UIStoryboard(storyboard: self).instantiateInitialViewController()!
    }
    
}
