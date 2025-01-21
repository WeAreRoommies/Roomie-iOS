//
//  HousesService.swift
//  Roomie
//
//  Created by MaengKim on 1/22/25.
//

import Foundation

import Moya

final class HousesService {
    let provider: MoyaProvider<HousesTargetType>
    
    init(provider: MoyaProvider<HousesTargetType> = MoyaProvider(plugins: [MoyaLoggingPlugin()])) {
        self.provider = provider
    }
    
    func request<T: ResponseModelType>(
        with request: HousesTargetType
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

extension HousesService: WishListServiceProtocol {
    func fetchWishListData() async throws -> BaseResponseBody<WishListResponseDTO>? {
        return try await self.request(with: .fetchWishLishData)
    }
}

final class MockHouseService: WishListServiceProtocol {
    func fetchWishListData() async throws -> BaseResponseBody<WishListResponseDTO>? {
        let mockData: WishListResponseDTO = WishListResponseDTO(pinnedHouses: [])
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
}
