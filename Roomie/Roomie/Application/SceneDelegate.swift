//
//  SceneDelegate.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit

import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureNotificationCenter()
        configureRootWindow(in: windowScene)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}

private extension SceneDelegate {
    func configureNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLogout),
            name: Notification.shouldLogout,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLogin),
            name: Notification.shouldLogin,
            object: nil
        )
    }
    
    func configureRootWindow(in windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        updateRootViewController()
        window.makeKeyAndVisible()
    }

    func updateRootViewController() {
        var rootViewController = UIViewController()
        
        if TokenManager.shared.isSessionAvailable {
            rootViewController = MainTabBarController()
        } else {
            rootViewController = UINavigationController(rootViewController: OnBoardingViewController())
        }
        
        window?.rootViewController = rootViewController
    }
    
    @objc
    func handleLogout() {
        TokenManager.shared.clearTokens()
        DispatchQueue.main.async {
            self.updateRootViewController()
        }
    }

    @objc
    func handleLogin(_ notification: Notification) {
        let fromManualLogin = notification.userInfo?["manualLogin"] as? Bool ?? false
        
        DispatchQueue.main.async {
            self.updateRootViewController()
            
            if fromManualLogin {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    Toast.show(message: "로그인에 성공했어요")
                }
            }
        }
    }
}
