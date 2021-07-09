//
//  TabBarViewController.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/3/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        delegate = self
    }
    
}

// MARK: -
// MARK: - UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let viewController_ = (viewController as? UINavigationController)?.topViewController
        guard viewController_ is CreateCommitScreenViewController else { return true }
        
        let createCommit_vc = Storyboard.createCommit.viewController
        present(createCommit_vc, animated: true)
        return false
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension TabBarViewController {
    
    private func configure() {
        configureTabBarAppearance()
        configureViewControllers()
    }
    
    private func configureTabBarAppearance() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = AppColor.richBlack
    }
    
    private func configureViewControllers() {
        viewControllers = TabBarItem.allCases.map {
            let nc = UINavigationController(rootViewController: $0.viewController)
            nc.navigationBar.isHidden = true
            return nc
        }
    }
    
}
