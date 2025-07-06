//
//  MoodListService.swift
//  Roomie
//
//  Created by 예삐 on 1/24/25.
//

import Foundation

import Moya

final class MoodListService {
    let provider: MoyaProvider<MoodListTargetType>
    
    init(provider: MoyaProvider<MoodListTargetType> = MoyaProvider(
        session: Session(interceptor: Interceptor.shared),
        plugins: [MoyaLoggingPlugin()])
    ) {
        self.provider = provider
    }
    
    func request<T: ResponseModelType>(
        with request: MoodListTargetType
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

extension MoodListService: MoodListServiceProtocol {
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>? {
        return try await self.request(with: .updatePinnedHouse(houseID: houseID))
    }
    
    func fetchMoodListData(moodTag: String) async throws -> BaseResponseBody<MoodListResponseDTO>? {
        return try await self.request(with: .fetchMoodListData(moodTag: moodTag))
    }
}

final class MockMoodListService: MoodListServiceProtocol {
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>? {
        let mockData: PinnedResponseDTO = PinnedResponseDTO(isPinned: false)
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
