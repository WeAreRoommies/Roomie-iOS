//
//  WishListResponseDTO.swift
//  Roomie
//
//  Created by MaengKim on 1/22/25.
//

import Foundation

struct WishListResponseDTO: ResponseModelType {
    let pinnedHouses: [WishHouse]
}

struct WishHouse: Codable, Hashable {
    let houseID: Int
    let monthlyRent, deposit, occupancyTypes, location: String
    let genderPolicy, locationDescription: String
    var isPinned: Bool
    let moodTag: String
    let contractTerm: Int
    let mainImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case houseID = "houseId"
        case monthlyRent, deposit, occupancyTypes, location, genderPolicy, locationDescription, isPinned, moodTag, contractTerm
        case mainImageURL = "mainImgUrl"
    }
}

