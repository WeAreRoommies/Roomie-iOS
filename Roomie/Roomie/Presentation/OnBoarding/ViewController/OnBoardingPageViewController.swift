//
//  OnBoardingPageViewController.swift
//  Roomie
//
//  Created by MaengKim on 5/21/25.
//

import UIKit
import Combine

import CombineCocoa

final class OnBoardingPageViewController: UIViewController {
    
    // MARK: - Property
    
    private let onBoardingView = OnBoardingScrollView()
    
    let loginView = OnBoardingLoginView()
    
    private let type: OnBoardingType
    
    private let cancelBag = CancelBag()
    
    private let homeViewModel: HomeViewModel
    
    // MARK: - Initializer
    
    init(type: OnBoardingType, viewModel: HomeViewModel) {
        self.type = type
        self.homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        if type.isLogin {
            self.view = loginView
        } else {
            onBoardingView.configure(with: type)
            self.view = onBoardingView
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    func getType() -> OnBoardingType {
        return type
    }
    
    func setAction() {
        loginView.kakaoLoginButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }

                let homeViewController = HomeViewController(viewModel: self.homeViewModel)
                let navigationViewController = UINavigationController(rootViewController: homeViewController)
                navigationViewController.modalPresentationStyle = .fullScreen
                self.present(navigationViewController, animated: true)
            }
            .store(in: cancelBag)
    }
}
