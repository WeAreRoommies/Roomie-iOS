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
    
    private let kakaoLoginButtonDidTap = PassthroughSubject<Void, Never>()
    
    private let appleLoginResultSubject = PassthroughSubject<String, Never>()
    
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
                self.kakaoLoginButtonDidTap.send()
            }
            .store(in: cancelBag)
        
        rootView.appleLoginButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                self.performAppleLogin()
            }
            .store(in: cancelBag)
    }
}

// MARK: - Functions

private extension LoginViewController {
    func bindViewModel() {
        let input = LoginViewModel.Input(
            kakaoLoginButtonDidTapSubject: kakaoLoginButtonDidTap.eraseToAnyPublisher(),
            appleLoginResultSubject: appleLoginResultSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.isLoginSucceedSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] isSucceed in
                guard let self = self else { return }
                if isSucceed {
                    self.navigationController?.pushViewController(MainTabBarController(), animated: true)
                }
            }
            .store(in: cancelBag)
    }
    
    func performAppleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(
        for controller: ASAuthorizationController
    ) -> ASPresentationAnchor {
        return self.view.window!
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let appleIDCredential = authorization.credential
                as? ASAuthorizationAppleIDCredential else { return }
        
        let identityToken = appleIDCredential.identityToken.flatMap {
            String(data: $0, encoding: .utf8)
        }
        
        if let identityToken {
            appleLoginResultSubject.send(identityToken)
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print("🚨Apple 로그인 실패: \(error.localizedDescription)")
    }
}
