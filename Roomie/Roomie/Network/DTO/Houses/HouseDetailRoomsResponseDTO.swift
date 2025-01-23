//
//  HouseDetailRoomsResponseDTO.swift
//  Roomie
//
//  Created by 김승원 on 1/23/25.
//

import Foundation

struct HouseDetailRoomsResponseDTO: ResponseModelType {
    let rooms: [HouseDetailRoom]
}

struct HouseDetailRoom: Codable {
    let roomID: Int
    let name: String
    let facility: [String]
    let status: Bool
    let mainImageURL: [String]

    enum CodingKeys: String, CodingKey {
        case roomID = "roomId"
        case name, facility, status
        case mainImageURL = "mainImageUrl"
    }
}
