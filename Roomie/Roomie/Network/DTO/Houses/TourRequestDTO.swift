//
//  TourRequestDTO.swift
//  Roomie
//
//  Created by 김승원 on 1/24/25.
//

import Foundation

struct TourRequestDTO: RequestModelType {
    let name: String
    let birth: String
    let gender: String
    let phoneNumber: String
    let preferredDate: String
    let message: String
    let roomID: Int
    let houseID: Int

    enum CodingKeys: String, CodingKey {
        case name, birth, gender, phoneNumber, preferredDate, message
        case roomID = "roomId"
        case houseID = "houseId"
    }
}
