//
//  HouseDetailServiceProtocol.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import Foundation

protocol HouseDetailServiceProtocol {
    func fetchHouseDetailData(houseID: Int) async throws -> BaseResponseBody<HouseDetailResponseDTO>?
}
