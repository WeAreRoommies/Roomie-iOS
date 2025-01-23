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

extension HousesService: HouseDetailServiceProtocol {
    func applyTour(request: TourRequestDTO, roomID: Int) async throws -> BaseResponseBody<TourResponseDTO>? {
        return try await self.request(with: .applyTour(request: request, roomID: roomID))
    }
    
    func fetchHouseDetailRoomsData(
        houseID: Int
    ) async throws -> BaseResponseBody<HouseDetailRoomsResponseDTO>? {
        return try await self.request(with: .fetchHouseDetailRoomsData(houseID: houseID))
    }
    
    func fetchHouseDetailImagesData(
        houseID: Int
    ) async throws -> BaseResponseBody<HouseDetailImagesResponseDTO>? {
        return try await self.request(with: .fetchHouseDetailImagesData(houseID: houseID))
    }
    
    func fetchHouseDetailData(houseID: Int) async throws -> BaseResponseBody<HouseDetailResponseDTO>? {
        return try await self.request(with: .fetchHouseDetailData(houseID: houseID))
    }
    
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>? {
        return try await self.request(with: .updatePinnedHouse(houseID: houseID))
    }
}
