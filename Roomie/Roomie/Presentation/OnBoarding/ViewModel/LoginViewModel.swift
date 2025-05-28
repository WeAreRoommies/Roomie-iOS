//
//  LoginViewModel.swift
//  Roomie
//
//  Created by 예삐 on 5/27/25.
//

import Foundation
import Combine

import KakaoSDKUser

final class LoginViewModel {
    private let service: AuthServiceProtocol
    
    private let isLoginSucceedSubject = PassthroughSubject<Bool, Never>()
    
    init(service: AuthServiceProtocol) {
        self.service = service
    }
}

extension LoginViewModel: ViewModelType {
    struct Input {
        let kakaoLoginButtonTapSubject: AnyPublisher<Void, Never>
        let appleLoginTokenSubject: AnyPublisher<String, Never>
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
        
        input.appleLoginTokenSubject
            .sink { [weak self] identityToken in
                guard let self else { return }
                print("identityToken: \(identityToken)")
                self.authLogin(
                    request: AuthLoginRequestDTO(
                        provider: "APPLE",
                        accessToken: identityToken
                    )
                )
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
                isLoginSucceedSubject.send(true)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
