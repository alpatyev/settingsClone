//
//  SceneDelegate.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        SettingsModel.setupData()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: SettingsViewController())
        window?.makeKeyAndVisible()
    }
}

