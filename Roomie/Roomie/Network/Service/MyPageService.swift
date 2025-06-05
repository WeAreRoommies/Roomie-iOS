//
//  UserService.swift
//  Roomie
//
//  Created by MaengKim on 1/21/25.
//

import Foundation

import Moya

final class MyPageService {
    let provider: MoyaProvider<MyPageTargetType>
    
    init(provider: MoyaProvider<MyPageTargetType> = MoyaProvider(
        session: Session(interceptor: Interceptor.shared),
        plugins: [MoyaLoggingPlugin()])
    ) {
        self.provider = provider
    }
    
    func request<T: ResponseModelType>(
        with request: MyPageTargetType
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

extension MyPageService: MyPageServiceProtocol {
    func fetchMyPageData() async throws -> BaseResponseBody<MyPageResponseDTO>? {
        return try await self.request(with: .fetchMyPageData)
    }
    
    func fetchMyAccountData() async throws -> BaseResponseBody<MyAccountResponseDTO>? {
        return try await self.request(with: .fetchMyAccountData)
    }
}

final class MockMyPageService: MyPageServiceProtocol {
    func fetchMyPageData() async throws -> BaseResponseBody<MyPageResponseDTO>? {
        let mockData = MyPageResponseDTO(nickname: "김루미", socialType: "KAKAO")
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func fetchMyAccountData() async throws -> BaseResponseBody<MyAccountResponseDTO>? {
        let mockData = MyAccountResponseDTO(
            nickname: "카드값줘체리",
            socialType: "KAKAO",
            name: "김루미",
            birthDate: "2025-06-06",
            phoneNumber: "010-1234-5678",
            gender: "여성"
        )
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
}
