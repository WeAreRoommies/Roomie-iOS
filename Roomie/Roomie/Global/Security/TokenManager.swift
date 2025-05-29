//
//  TokenManager.swift
//  Roomie
//
//  Created by 김승원 on 5/29/25.
//

import Foundation

final class TokenManager {
    
    static let shared = TokenManager()
    private let keychain = KeychainManager.shared
    
    private init() {}
    
    /// 로그인 성공 시 토큰을 저장합니다.
    func saveTokens(accessToken: String, refreshToken: String) {
        keychain.create(forKey: .accessToken, token: accessToken)
        keychain.create(forKey: .refreshToken, token: refreshToken)
    }
    
    /// 저장된 accessToken을 반환합니다.
    func fetchAccessToken() -> String? {
        return keychain.read(forKey: .accessToken)
    }

    /// 저장된 refreshToken을 반환합니다.
    func fetchRefreshToken() -> String? {
        return keychain.read(forKey: .refreshToken)
    }
    
    /// 로그아웃 시 모든 토큰을 삭제합니다.
    func clearTokens() {
        keychain.delete(forKey: .accessToken)
        keychain.delete(forKey: .refreshToken)
    }
    
    /// accessToken이 저장되어 있는지 확인합니다.
    /// 로그인 확인용으로 사용합니다.
    var hasValidAccessToken: Bool {
        return fetchAccessToken()?.isEmpty == false
    }
}
