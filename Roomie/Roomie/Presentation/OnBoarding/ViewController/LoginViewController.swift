//
//  LoginViewController.swift
//  Roomie
//
//  Created by MaengKim on 5/25/25.
//

import UIKit

import SnapKit
import Combine

import AuthenticationServices

final class LoginViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = LoginView()
    
    private let loginButtonTapSubject = PassthroughSubject<SocialType, Never>()
    
    private let viewModel: LoginViewModel
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    override func setAction() {
        rootView.kakaoLoginButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.loginButtonTapSubject.send(.kakao)
            }
            .store(in: cancelBag)
        
        rootView.appleLoginButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                self.loginButtonTapSubject.send(.apple)
            }
            .store(in: cancelBag)
    }
}

// MARK: - Functions

private extension LoginViewController {
    func bindViewModel() {
        let input = LoginViewModel.Input(
            loginButtonTapSubject: loginButtonTapSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.isLoginSucceedSubject
            .receive(on: RunLoop.main)
            .sink { isSucceed in
                if isSucceed {
                    NotificationCenter.default.post(name: Notification.shouldLogin, object: nil)
                }
            }
            .store(in: cancelBag)
    }
}
