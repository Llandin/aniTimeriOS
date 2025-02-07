//
//  AppDelegate.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 03/09/24.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseAppCheck
import GoogleSignIn


@main
    class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        AppCheck.setAppCheckProviderFactory(DeviceCheckProviderFactory())
        ImageCache.shared.cleanDiskCache()
        return true
    }

    // MARK: UISceneSession Lifecycle
        
    func applicationDidEnterBackground(_ application: UIApplication) {
        ImageCache.shared.cleanDiskCache() // Cleanup when entering background
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
        
        func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            return GIDSignIn.sharedInstance.handle(url)
        }

}

