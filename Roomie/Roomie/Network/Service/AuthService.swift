//
//  AuthService.swift
//  Roomie
//
//  Created by 예삐 on 5/27/25.
//

import Foundation

import Moya

final class AuthService {
    let provider: MoyaProvider<AuthTargetType>
    
    init(provider: MoyaProvider<AuthTargetType> = MoyaProvider(plugins: [MoyaLoggingPlugin()])) {
        self.provider = provider
    }
    
    func request<T: ResponseModelType>(
        with request: AuthTargetType
    ) async throws -> BaseResponseBody<T>? {
        return try await withCheckedThrowingContinuation {
            continuation in provider.request(request) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(
                            BaseResponseBody<T>.self, from: response.data
                        )
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

extension AuthService: AuthServiceProtocol {
    func authLogin(
        request: AuthLoginRequestDTO
    ) async throws -> BaseResponseBody<AuthLoginResponseDTO>? {
        return try await self.request(with: .authLogin(request: request))
    }
    
    func authReissue(refreshToken: String) async throws -> BaseResponseBody<AuthReissueResponseDTO>? {
        return try await self.request(with: .authReissue(refreshToken: refreshToken))
    }
}
