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
    
    // MARK: - UIComponent
    
    private let rootView = LoginView()
    
    override func loadView() {
        view = rootView
    }
    
    override func setAction() {
        rootView.kakaoLoginButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.navigationController?.pushViewController(MainTabBarController(), animated: true)
            }
            .store(in: cancelBag)
    }
}
