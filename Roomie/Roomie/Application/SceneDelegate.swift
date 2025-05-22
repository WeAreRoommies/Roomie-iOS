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
        let viewModel = OnBoardingViewModel()
        let homeViewModel = HomeViewModel(service: HomeService())
        let onboarding = OnBoardingContainerViewController(viewModel: viewModel, homeViewModel: homeViewModel)
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = UINavigationController(rootViewController: onboarding)
        self.window?.makeKeyAndVisible()
    }
}
