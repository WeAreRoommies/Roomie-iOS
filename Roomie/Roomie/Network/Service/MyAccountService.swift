//
//  MyAccountService.swift
//  Roomie
//
//  Created by 예삐 on 6/26/25.
//

import Foundation

import Moya

final class MyAccountService {
    let provider: MoyaProvider<MyAccountTargetType>
    
    init(provider: MoyaProvider<MyAccountTargetType> = MoyaProvider(
        session: Session(interceptor: Interceptor.shared),
        plugins: [MoyaLoggingPlugin()])
    ) {
        self.provider = provider
    }
    
    func request<T: ResponseModelType>(
        with request: MyAccountTargetType
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

extension MyAccountService: MyAccountServiceProtocol {
    func fetchMyAccountData() async throws -> BaseResponseBody<MyAccountResponseDTO>? {
        return try await self.request(with: .fetchMyAccountData)
    }
}

final class MockMyAccountService: MyAccountServiceProtocol {
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
