//
//  MoodListResponseDTO.swift
//  Roomie
//
//  Created by MaengKim on 1/22/25.
//

import Foundation

struct MoodListResponseDTO: ResponseModelType {
    let moodTag: String
    let houses: [MoodHouse]
}

struct MoodHouse: Codable, Hashable {
    let houseID: Int
    let monthlyRent, deposit, occupancyTypes, location: String
    let genderPolicy, locationDescription: String
    let isPinned: Bool
    let contractTerm: Int
    let mainImgURL: String

    enum CodingKeys: String, CodingKey {
        case houseID = "houseId"
        case monthlyRent, deposit, occupancyTypes, location, genderPolicy, locationDescription, isPinned
        case contractTerm = "contract_term"
        case mainImgURL = "mainImgUrl"
    }
}
