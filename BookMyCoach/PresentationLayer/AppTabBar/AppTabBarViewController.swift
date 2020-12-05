//
//  AppTabBarViewController.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import UIKit

class AppTabBarViewController: UITabBarController {

    class func create(_ userType: UserType) -> UITabBarController {
        let tabBarController = AppTabBarViewController()
        var items: [UIViewController] = []
        
        let homeController = AppDICoordinator.homeViewController(userType)
        homeController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: nil)
        items.append(AppDICoordinator.appNavigation(homeController))
        
        if userType == .coach {
            let memberController = AppDICoordinator.memberViewController()
            memberController.tabBarItem = UITabBarItem(title: "Member", image: UIImage(systemName: "list.bullet"), selectedImage: nil)
            items.append(AppDICoordinator.appNavigation(memberController))
        }
        
        let chatController = AppDICoordinator.chatViewController()
        chatController.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "message.fill"), selectedImage: nil)
        items.append(AppDICoordinator.appNavigation(chatController))
        
        let profileController = AppDICoordinator.profileViewController()
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), selectedImage: nil)
        items.append(AppDICoordinator.appNavigation(profileController))
        
        tabBarController.viewControllers = items
        
        return tabBarController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.white
        self.tabBar.barTintColor = UIColor.themeBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.toolbarItems?.first?.title = "Home"
    }

}
