//
//  UserService.swift
//  Roomie
//
//  Created by MaengKim on 1/21/25.
//

import Foundation

import Moya

final class UserService {
    let provider: MoyaProvider<UserTargetType>
    
    init(provider: MoyaProvider<UserTargetType> = MoyaProvider(plugins: [MoyaLoggingPlugin()])) {
        self.provider = provider
    }
    
    func request<T: ResponseModelType>(
        with request: UserTargetType
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

extension UserService: HomeServiceProtocol {
    func fetchHomeData() async throws -> BaseResponseBody<HomeResponseDTO>? {
        return try await self.request(with: .fetchUserHomeData)
    }
}

extension UserService: MyPageServiceProtocol {
    func fetchMyPageData() async throws -> BaseResponseBody<MyPageResponseDTO>? {
        return try await self.request(with: .fetchMyPageData)
    }
}

final class MockHomeService: HomeServiceProtocol {
    func fetchHomeData() async throws -> BaseResponseBody<HomeResponseDTO>? {
        let mockData: HomeResponseDTO =
        HomeResponseDTO(name: "김루미", location: "논현동", recentlyViewedHouses: [])
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
}

final class MockMyPageService: MyPageServiceProtocol {
    func fetchMyPageData() async throws -> BaseResponseBody<MyPageResponseDTO>? {
        let mockData = MyPageResponseDTO(name: "김루미")
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
}
