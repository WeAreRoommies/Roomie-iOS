//
//  HomeService.swift
//  Roomie
//
//  Created by 예삐 on 1/23/25.
//

import Foundation

import Moya

final class HomeService {
    let provider: MoyaProvider<HomeTargetType>
    
    init(provider: MoyaProvider<HomeTargetType> = MoyaProvider(plugins: [MoyaLoggingPlugin()])) {
        self.provider = provider
    }
    
    func request<T: ResponseModelType>(
        with request: HomeTargetType
    ) async throws -> BaseResponseBody<T>? {
        return try await withCheckedThrowingContinuation {
            continuation in provider.request(request) {
                result in
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

extension HomeService: HomeServiceProtocol {
    func fetchHomeData() async throws -> BaseResponseBody<HomeResponseDTO>? {
        return try await self.request(with: .fetchUserHomeData)
    }
    
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>? {
        return try await self.request(with: .updatePinnedHouse(houseID: houseID))
    }
}

final class MockHomeService: HomeServiceProtocol {
    func fetchHomeData() async throws -> BaseResponseBody<HomeResponseDTO>? {
        let mockData: HomeResponseDTO =
        HomeResponseDTO(name: "김루미", location: "논현동", recentlyViewedHouses: [])
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>? {
        let mockData: PinnedResponseDTO = PinnedResponseDTO(isPinned: false)
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
}
