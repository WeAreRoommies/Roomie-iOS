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
}
