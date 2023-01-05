//
//  AppDelegate.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SettingsModel.setupData()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: SettingsViewController())
        window?.makeKeyAndVisible()
        return true
    }

}

