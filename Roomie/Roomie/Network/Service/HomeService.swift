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
    
    init(provider: MoyaProvider<HomeTargetType> = MoyaProvider(
        session: Session(interceptor: Interceptor.shared),
        plugins: [MoyaLoggingPlugin()])
    ) {
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
    
    func fetchLocationSearchData(query: String) async throws -> BaseResponseBody<MapSearchResponseDTO>? {
        return try await self.request(with: .fetchLocationSearchData(query: query))
    }
    
    func fetchUserLocation(latitude: Double, longitude: Double, location: String) async throws -> BaseResponseBody<UserLocationResponseDTO>? {
        return try await self.request(with: .fetchUserLocation(latitude: latitude, longitude: longitude, location: location))
    }
}

final class MockHomeService: HomeServiceProtocol {
    func fetchLocationSearchData(query: String) async throws -> BaseResponseBody<MapSearchResponseDTO>? {
        let mockData: MapSearchResponseDTO = MapSearchResponseDTO(
            locations: [
                Location(
                    x: 0,
                    y: 0,
                    location: "이화여자대학교",
                    address: "서울특별시 서대문구 대현동 11-1",
                    roadAddress: "서울특별시 서대문구 이화여대길 52"
                ),
                Location(
                    x: 0,
                    y: 0,
                    location: "건국대학교",
                    address: "서울특별시 서대문구 대현동 11-1",
                    roadAddress: "서울특별시 서대문구 이화여대길 52"
                ),
                Location(
                    x: 0,
                    y: 0,
                    location: "성신여자대학교",
                    address: "서울특별시 서대문구 대현동 11-1",
                    roadAddress: "서울특별시 서대문구 이화여대길 52"
                ),
                Location(
                    x: 0,
                    y: 0,
                    location: "홍익대학교",
                    address: "서울특별시 서대문구 대현동 11-1",
                    roadAddress: "서울특별시 서대문구 이화여대길 52"
                ),
                Location(
                    x: 0,
                    y: 0,
                    location: "가톨릭대학교",
                    address: "서울특별시 서대문구 대현동 11-1",
                    roadAddress: "서울특별시 서대문구 이화여대길 52"
                )
            ]
        )
        
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func fetchHomeData() async throws -> BaseResponseBody<HomeResponseDTO>? {
        let mockData: HomeResponseDTO =
        HomeResponseDTO(nickname: "김루미", location: "논현동", recentlyViewedHouses: [
            HomeHouse(
                    houseID: 1,
                    monthlyRent: "43 ~ 50",
                    deposit: "90 ~ 100",
                    occupancyTypes: "1,2,3인실",
                    location: "서대문구 연희동",
                    genderPolicy: "여성전용",
                    locationDescription: "자이아파트",
                    isPinned: false,
                    moodTag: "차분한",
                    contractTerm: 3,
                    mainImageURL: "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2Foriginals%2F32%2Fab%2F6a%2F32ab6a8f37b33c4d7922505824a1af86.jpg&type=sc960_832"
                )
        ])
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>? {
        let mockData: PinnedResponseDTO = PinnedResponseDTO(isPinned: false)
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func fetchUserLocation(latitude: Double, longitude: Double, location: String) async throws -> BaseResponseBody<UserLocationResponseDTO>? {
        let mockData: UserLocationResponseDTO = UserLocationResponseDTO(latitude: 11, longitude: 11, location: "MOCK")
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
}
