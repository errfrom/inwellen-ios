//
//  AppDelegate.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/13/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit
import SwiftyBeaver

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
    weak var rootNavigationController: UINavigationController?
}

// MARK: -
// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()
        return true
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension AppDelegate {
    
    private func configure() {
        configureSwiftyBeaverLogDestinations()
        configureWindow()
        configureRootViewController()
    }
    
    private func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }
    
    private func configureRootViewController() {
        let createCommit_vc = Storyboard.createCommit.viewController as! CreateCommitScreenViewController
        
        let nc = UINavigationController(rootViewController: createCommit_vc)
        nc.navigationBar.isTranslucent = false
        nc.setNavigationBarHidden(true, animated: false)
        
        self.window?.rootViewController = nc
        self.rootNavigationController = nc
    }
    
    private func configureSwiftyBeaverLogDestinations() {
        if DEBUG {
            let consoleDest = ConsoleDestination()
            consoleDest.format = "$DHH:mm:ss$d $T $C$L: $M | $X"
            log.addDestination(consoleDest)
        }
    }
    
}
