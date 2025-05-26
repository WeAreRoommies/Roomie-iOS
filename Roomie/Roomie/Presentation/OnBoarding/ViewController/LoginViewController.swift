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
        
        rootView.appleLoginButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                self.appleLoginButtonDidTap()
            }
            .store(in: cancelBag)
    }
}

extension LoginViewController {
    func appleLoginButtonDidTap() {
        print("애플 로그인 시작")
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = []
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        
        let identityToken = appleIDCredential.identityToken.flatMap {
            String(data: $0, encoding: .utf8)
        }
        
        print("✅ Apple 로그인 성공!!!")
        print("IdentityToken: \(String(describing: identityToken))")
        
        /*
         Todo: Keychain에 애플 로그인 정보 저장
         */

        /*
         Todo: 서버 통신 메서드 호출
         */
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        /*
         Todo: 에러 핸들링 (ex. alert창)
         */
        print("🚨Apple 로그인 실패: \(error.localizedDescription)")
    }
}
