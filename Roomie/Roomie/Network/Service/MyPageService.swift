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
}

final class MockMyPageService: MyPageServiceProtocol {
    func fetchMyPageData() async throws -> BaseResponseBody<MyPageResponseDTO>? {
        let mockData = MyPageResponseDTO(nickname: "김루미", socialType: "KAKAO")
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
}
