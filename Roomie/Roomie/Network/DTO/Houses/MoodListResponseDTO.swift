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
    var isPinned: Bool
    let contractTerm: Int
    let mainImageURL: String

    enum CodingKeys: String, CodingKey {
        case houseID = "houseId"
        case monthlyRent, deposit, occupancyTypes, location, genderPolicy
        case locationDescription, isPinned, contractTerm
        case mainImageURL = "mainImgUrl"
    }
}
