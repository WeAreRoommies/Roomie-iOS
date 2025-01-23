//
//  WishListService.swift
//  Roomie
//
//  Created by 예삐 on 1/24/25.
//

import Foundation

import Moya

final class WishListService {
    let provider: MoyaProvider<WishListTargetType>
    
    init(provider: MoyaProvider<WishListTargetType> = MoyaProvider(plugins: [MoyaLoggingPlugin()])) {
        self.provider = provider
    }
    
    func request<T: ResponseModelType>(
        with request: WishListTargetType
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

extension WishListService: WishListServiceProtocol {
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>? {
        return try await self.request(with: .updatePinnedHouse(houseID: houseID))
    }
    
    func fetchWishListData() async throws -> BaseResponseBody<WishListResponseDTO>? {
        return try await self.request(with: .fetchWishLishData)
    }
}

final class MockWishListService: WishListServiceProtocol {
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>? {
        let mockData: PinnedResponseDTO = PinnedResponseDTO(isPinned: false)
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func fetchWishListData() async throws -> BaseResponseBody<WishListResponseDTO>? {
        let mockData: WishListResponseDTO = WishListResponseDTO(pinnedHouses: [])
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
}
