//
//  TabBarControlelr.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 19/09/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
        
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.tintColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        let storyboard1 = UIStoryboard(name: "HomeView", bundle: nil)
        let homeViewController = storyboard1.instantiateViewController(withIdentifier: "HomeViewController")
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let storyboard2 = UIStoryboard(name: "SearchViewController", bundle: nil)
        let searchViewController = storyboard2.instantiateViewController(withIdentifier: "SearchViewController")
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let storyboard3 = UIStoryboard(name: "ProfileView", bundle: nil)
        let profileViewController = storyboard3.instantiateViewController(withIdentifier: "ProfileView")
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        
        self.viewControllers = [homeViewController, searchViewController,profileViewController]
    }
}
