//
//  HouseDetailServiceProtocol.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import Foundation

protocol HouseDetailServiceProtocol {
    func fetchHouseDetailData(houseID: Int)
    async throws -> BaseResponseBody<HouseDetailResponseDTO>?
    
    func fetchHouseDetailImagesData(houseID: Int)
    async throws -> BaseResponseBody<HouseDetailImagesResponseDTO>?
    
    func fetchHouseDetailRoomsData(houseID: Int)
    async throws -> BaseResponseBody<HouseDetailRoomsResponseDTO>?
    
    func applyTour(request: TourRequestDTO, roomID: Int) async throws -> BaseResponseBody<TourResponseDTO>?
    
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinnedResponseDTO>?
}
