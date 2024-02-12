//
//  MainTabBarController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/12/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let findViewController = UINavigationController(rootViewController: FindViewController())
    private let profileViewController = UINavigationController(rootViewController: ProfileViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureHirearchy()
        configureView()
    }
    
    private func configureHirearchy() {
        viewControllers = [findViewController, profileViewController]
    }
    
    private func configureView() {
        tabBar.tintColor = .white
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = .lightGray
        
        findViewController.tabBarItem.title = "검색"
        findViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        profileViewController.tabBarItem.title = "프로필"
        profileViewController.tabBarItem.image = UIImage(systemName: "person")
    }
}
