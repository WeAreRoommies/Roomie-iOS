//
//  HomeServiceProtocol.swift
//  Roomie
//
//  Created by MaengKim on 1/21/25.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchHomeData() async throws -> BaseResponseBody<HomeResponseDTO>?
    
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>?
    
    func fetchLocationSearchData(query: String) async throws -> BaseResponseBody<MapSearchResponseDTO>?
}
