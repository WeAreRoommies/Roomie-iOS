//
//  LoginViewModel.swift
//  Roomie
//
//  Created by 예삐 on 5/27/25.
//

import AuthenticationServices
import Foundation
import Combine

import KakaoSDKUser

final class LoginViewModel: NSObject {
    private let service: AuthServiceProtocol
    
    private let isLoginSucceedSubject = PassthroughSubject<Bool, Never>()
    
    init(service: AuthServiceProtocol) {
        self.service = service
    }
}

extension LoginViewModel: ViewModelType {
    struct Input {
        let kakaoLoginButtonTapSubject: AnyPublisher<Void, Never>
        let appleLoginButtonTapSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let isLoginSucceedSubject: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.kakaoLoginButtonTapSubject
            .sink { [weak self] in
                guard let self = self else { return }
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        if let error = error {
                            print(">>> \(error.localizedDescription) : \(#function)")
                        } else {
                            guard let oauthToken = oauthToken else { return }
                            self.authLogin(
                                request: AuthLoginRequestDTO(
                                    provider: "KAKAO",
                                    accessToken: oauthToken.accessToken
                                )
                            )
                        }
                    }
                }
            }
            .store(in: cancelBag)
        
        input.appleLoginButtonTapSubject
            .sink { [weak self] in
                guard let self else { return }
                self.performAppleLogin()
            }
            .store(in: cancelBag)
        
        let isLoginSucceed = isLoginSucceedSubject.eraseToAnyPublisher()
        
        return Output(
            isLoginSucceedSubject: isLoginSucceed
        )
    }
}

private extension LoginViewModel {
    func authLogin(request: AuthLoginRequestDTO) {
        Task {
            do {
                guard let responseBody = try await service.authLogin(request: request),
                      let data = responseBody.data else { return }
                saveTokens(accessToken: data.accessToken, refreshToken: data.refreshToken)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
    func saveTokens(accessToken: String, refreshToken: String) {
        TokenManager.shared.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
        isLoginSucceedSubject.send(true)
        NotificationCenter.default.post(name: Notification.shouldLogin, object: nil)
    }
    
    func performAppleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension LoginViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(
        for controller: ASAuthorizationController
    ) -> ASPresentationAnchor {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window!
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension LoginViewModel: ASAuthorizationControllerDelegate {
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
            self.authLogin(
                request: AuthLoginRequestDTO(
                    provider: "APPLE",
                    accessToken: identityToken
                )
            )
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print("🚨Apple 로그인 실패: \(error.localizedDescription)")
    }
}
