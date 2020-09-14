//
//  AppDelegate.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/13/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let vc = UIStoryboard(storyboard: .main).instantiateInitialViewController()
        window?.rootViewController = vc
        return true
    }

}

