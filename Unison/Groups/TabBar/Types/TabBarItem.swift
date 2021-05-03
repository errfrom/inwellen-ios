//
//  TabBarItem.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/3/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

enum TabBarItem: CaseIterable {
    case homeItem
    case draftsItem
    case createCommitItem
    case notificationsItem
    case profileItem
    
    var viewController: UIViewController {
        let vc = Storyboard.createCommit.viewController
        vc.tabBarItem = item
        return vc
    }
    
}

// MARK: -
// MARK: - Internal

fileprivate extension TabBarItem {
    
    private var item: UITabBarItem {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = itemImage
        tabBarItem.selectedImage = selectedItemImage
        tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        return tabBarItem
    }
    
    private var itemImage: UIImage? {
        return UIImage(named: "\(imageName)-notselected")?
            .withRenderingMode(.alwaysOriginal)
    }
    
    private var selectedItemImage: UIImage? {
        return UIImage(named: "\(imageName)-selected")?
            .withRenderingMode(.alwaysOriginal)
    }
    
    private var imageName: String {
        switch self {
            case .homeItem:
                return "tabbar-home"
            
            case .draftsItem:
                return "tabbar-list"
            
            case .createCommitItem:
                return "tabbar-add"
            
            case .notificationsItem:
                return "tabbar-notifications"
            
            case .profileItem:
                return "tabbar-profile"
        }
    }
    
}
