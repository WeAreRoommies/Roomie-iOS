//
//  MainTabBarController.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import UIKit

import Then

final class MainTabBarController: UITabBarController {
    
    // MARK: - Property
    
    let homeViewController: HomeViewController = HomeViewController().then {
        $0.tabBarItem.title = "홈"
        $0.tabBarItem.image = .icnHomeLine24
    }
    
    let mapViewController: MapViewController = MapViewController().then {
        $0.tabBarItem.title = "지도"
        $0.tabBarItem.image = .icnMapLine24
    }
    
    let myPageViewController: MyPageViewController = MyPageViewController().then {
        $0.tabBarItem.title = "마이페이지"
        $0.tabBarItem.image = .icnUserLine24
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    // MARK: - Functions
    
    private func setTabBar() {
        let borderView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.bounds.width, height: 1))
        borderView.backgroundColor = .grayscale4
        tabBar.addSubview(borderView)
        
        tabBar.unselectedItemTintColor = .grayscale10
        tabBar.tintColor = .primaryPurple
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        let homeNavigationController = UINavigationController(
            rootViewController: homeViewController
        )
        
        let mapNavigationController = UINavigationController(
            rootViewController: mapViewController
        )
        
        let myPageViewNavigationController = UINavigationController(
            rootViewController: myPageViewController
        )
        
        setViewControllers([
            homeNavigationController,
            mapNavigationController,
            myPageViewNavigationController
        ], animated: true)
    }
}
