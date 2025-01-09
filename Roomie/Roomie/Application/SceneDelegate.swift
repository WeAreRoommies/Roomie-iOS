//
//  SceneDelegate.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: MainTabBarController())
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
