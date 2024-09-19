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

        let storyboard1 = UIStoryboard(name: "HomeView", bundle: nil)
        let homeViewController = storyboard1.instantiateViewController(withIdentifier: "HomeView")
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let storyboard2 = UIStoryboard(name: "SearchViewController", bundle: nil)
        let searchViewController = storyboard2.instantiateViewController(withIdentifier: "SearchViewController")
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "person"), tag: 1)
        
        let storyboard3 = UIStoryboard(name: "ProfileView", bundle: nil)
        let profileViewController = storyboard3.instantiateViewController(withIdentifier: "ProfileView")
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        // Add the view controllers to the tab bar
        self.viewControllers = [homeViewController, searchViewController,profileViewController]
    }
}
