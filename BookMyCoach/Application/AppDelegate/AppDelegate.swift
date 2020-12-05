//
//  AppDelegate.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 02/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var shared: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        StorageManager.initialize()
        
        self.window?.rootViewController = AppDICoordinator.rootController()
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

