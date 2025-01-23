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
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>? {
        return try await self.request(with: .updatePinnedHouse(houseID: houseID))
    }
    
    func fetchWishListData() async throws -> BaseResponseBody<WishListResponseDTO>? {
        return try await self.request(with: .fetchWishLishData)
    }
}

extension HousesService: HouseDetailServiceProtocol {
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
    
    // TODO: 찜 API 추가
}

extension HousesService: MoodListServiceProtocol {
    func fetchMoodListData(moodTag: String) async throws -> BaseResponseBody<MoodListResponseDTO>? {
        return try await self.request(with: .fetchMoodListData(moodTag: moodTag))
    }
    
    // TODO: 찜 API 추가
}

final class MockHouseService: WishListServiceProtocol {
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>? {
        let mockData: PinnedResponseDTO = PinnedResponseDTO(isPinned: false)
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func fetchWishListData() async throws -> BaseResponseBody<WishListResponseDTO>? {
        let mockData: WishListResponseDTO = WishListResponseDTO(pinnedHouses: [])
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func fetchMoodListData(moodTag: String) async throws -> BaseResponseBody<MoodListResponseDTO>? {
        let mockData: MoodListResponseDTO = MoodListResponseDTO(
            moodTag: "#차분한",
            houses: [
            MoodHouse(
                houseID: 1,
                monthlyRent: "30~50",
                deposit: "200~300",
                occupancyTypes: "1,2인실",
                location: "서대문구 연희동",
                genderPolicy: "여성전용",
                locationDescription: "자이아파트",
                isPinned: false,
                contractTerm: 6,
                mainImageURL: ""
            ),
            MoodHouse(
                houseID: 2,
                monthlyRent: "30~50",
                deposit: "200~300",
                occupancyTypes: "1,2,3인실",
                location: "서대문구 대현동",
                genderPolicy: "성별무관",
                locationDescription: "자이아파트",
                isPinned: true,
                contractTerm: 6,
                mainImageURL: ""
            )
        ])
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
}
