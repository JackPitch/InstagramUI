//
//  MainTabBarController.swift
//  InstagramUI
//
//  Created by Jackson Pitcher on 10/31/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
        setupViewControllers()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    func setupViewControllers() {
        view.backgroundColor = .white
        
        //home
        let homeNavController = templateNavController(imageSelected: #imageLiteral(resourceName: "home_selected"), imageUnselected: #imageLiteral(resourceName: "home_unselected"), rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //search
        let searchNavController = templateNavController(imageSelected: #imageLiteral(resourceName: "search_selected"), imageUnselected: #imageLiteral(resourceName: "search_unselected"), rootViewController: UserSearchController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //like
        let likeNavController = templateNavController(imageSelected: #imageLiteral(resourceName: "like_selected"), imageUnselected: #imageLiteral(resourceName: "like_selected"))
        
        //plus
        let plusNavController = templateNavController(imageSelected: #imageLiteral(resourceName: "plus_unselected"), imageUnselected: #imageLiteral(resourceName: "plus_unselected"))
        
        //user profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected").withRenderingMode(.alwaysOriginal)
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected").withRenderingMode(.alwaysOriginal)
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController, searchNavController, plusNavController, likeNavController, userProfileNavController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(imageSelected: UIImage, imageUnselected: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let controller = rootViewController
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.image = imageUnselected
        navController.tabBarItem.selectedImage = imageSelected
        return navController
    }
}
