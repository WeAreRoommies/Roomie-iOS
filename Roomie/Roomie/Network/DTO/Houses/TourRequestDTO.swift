//
//  TourRequestDTO.swift
//  Roomie
//
//  Created by 김승원 on 1/24/25.
//

import Foundation

struct TourRequestDTO: Codable {
    let name, birth, gender, phoneNumber: String
    let preferredDate, message: String
    let roomID, houseID: Int

    enum CodingKeys: String, CodingKey {
        case name, birth, gender, phoneNumber, preferredDate, message
        case roomID = "roomId"
        case houseID = "houseId"
    }
}
