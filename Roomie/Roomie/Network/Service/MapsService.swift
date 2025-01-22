//
//  MapsService.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

import Foundation

import Moya

final class MapsService {
    let provider: MoyaProvider<MapsTargetType>
    
    init(provider: MoyaProvider<MapsTargetType> = MoyaProvider(plugins: [MoyaLoggingPlugin()])) {
        self.provider = provider
    }
    
    func request<T: ResponseModelType>(
        with request: MapsTargetType
    ) async throws -> BaseResponseBody<T>? {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(request) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(
                            BaseResponseBody<T>.self,
                            from: response.data
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

extension MapsService: MapServiceProtocol {
    func fetchMapData(request: MapRequestDTO) async throws -> BaseResponseBody<MapResponseDTO>? {
        return try await self.request(with: .fetchMapData(request: request))
    }
    
    // TODO: 찜 API 추가
}

extension MapsService: MapSearchServiceProtocol {
    func fetchMapSearchData(query: String) async throws -> BaseResponseBody<MapSearchResponseDTO>? {
        return try await self.request(with: .fetchMapSearchData(query: query))
    }
}

final class MockMapSearchService: MapSearchServiceProtocol {
    func fetchMapSearchData(query: String) async throws -> BaseResponseBody<MapSearchResponseDTO>? {
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
    
    func fetchMapData(request: MapRequestDTO) async throws -> BaseResponseBody<MapResponseDTO>? {
        let mockData: MapResponseDTO = MapResponseDTO(
            houses: [
                House(
                    houseID: 1,
                    x: 37.555184166,
                    y: 126.936910322,
                    monthlyRent: "35~50",
                    deposit: "200~300",
                    occupancyTypes: "2인실",
                    location: "마포구 신촌동",
                    genderPolicy: "여성전용",
                    locationDescription: "신촌하우스",
                    isPinned: true,
                    moodTag: "#차분한",
                    contractTerm: 6,
                    mainImageURL: ""
                ),
                House(
                    houseID: 2,
                    x: 37.552502661,
                    y: 126.934998613,
                    monthlyRent: "25~40",
                    deposit: "50~100",
                    occupancyTypes: "4인실",
                    location: "마포구 대흥동",
                    genderPolicy: "여성전용",
                    locationDescription: "서강하우스",
                    isPinned: true,
                    moodTag: "#깔끔한",
                    contractTerm: 6,
                    mainImageURL: ""
                ),
                House(
                    houseID: 3,
                    x: 37.553909,
                    y: 126.933960,
                    monthlyRent: "50~80",
                    deposit: "300~500",
                    occupancyTypes: "1인실",
                    location: "마포구 노고산동",
                    genderPolicy: "여성전용",
                    locationDescription: "신촌 맹그로브",
                    isPinned: false,
                    moodTag: "#활발한",
                    contractTerm: 12,
                    mainImageURL: ""
                ),
                House(
                    houseID: 4,
                    x: 37.556304,
                    y: 126.943263,
                    monthlyRent: "30~50",
                    deposit: "100~300",
                    occupancyTypes: "2인실",
                    location: "마포구 신촌동",
                    genderPolicy: "남녀분리",
                    locationDescription: "이화하우스",
                    isPinned: true,
                    moodTag: "#활발한",
                    contractTerm: 12,
                    mainImageURL: ""
                ),
                House(
                    houseID: 5,
                    x: 37.547670,
                    y: 126.942370,
                    monthlyRent: "50~70",
                    deposit: "50~100",
                    occupancyTypes: "3인실",
                    location: "마포구 대흥동",
                    genderPolicy: "여성전용",
                    locationDescription: "대흥하우스",
                    isPinned: true,
                    moodTag: "#조용한",
                    contractTerm: 6,
                    mainImageURL: ""
                )
            ]
        )
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
}
