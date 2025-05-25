//
//  LoginViewController.swift
//  Roomie
//
//  Created by MaengKim on 5/25/25.
//

import UIKit

import SnapKit
import Combine

final class LoginViewController: BaseViewController {
    
    // MARK: - Property
    
    private let cancelBag = CancelBag()
    
    private let homeViewModel = HomeViewModel(service: HomeService())
    
    // MARK: - UIComponent
    
    private let loginView = OnBoardingLoginView()
    
    // MARK: - LifeCycle
    
    override func setView() {
        super.setView()
        view.addSubview(loginView)
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setAction() {
        loginView.kakaoLoginButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                let homeViewController = HomeViewController(viewModel: homeViewModel)
                self.navigationController?.pushViewController(homeViewController, animated: true)
            }
            .store(in: cancelBag)
    }
}
