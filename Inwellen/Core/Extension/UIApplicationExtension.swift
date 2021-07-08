//
//  UIApplicationExtension.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/12/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var currentViewController: UIViewController? {
        
        func worker(vc: UIViewController?) -> UIViewController? {
            if let nc = vc as? UINavigationController {
                return worker(vc: nc.visibleViewController)
            } else if let tbc = vc as? UITabBarController {
                return worker(vc: tbc.selectedViewController)
            } else if let presentedByVC = vc?.presentedViewController {
                return worker(vc: presentedByVC)
            } else {
                return vc
            }
        }

        let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        return worker(vc: keyWindow?.rootViewController)
    }
    
}
