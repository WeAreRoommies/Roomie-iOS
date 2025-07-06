//
//  MapResponseDTO.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

import Foundation

struct MapResponseDTO: ResponseModelType {
    let houses: [House]
}

struct House: Codable, Hashable {
    let houseID: Int
    let latitude, longitude: Double
    let monthlyRent, deposit: String
    let occupancyTypes: String
    let location, genderPolicy, locationDescription: String
    var isPinned: Bool
    let moodTag: String
    let contractTerm: Int
    let mainImageURL: String
    let isFull: Bool
    
    enum CodingKeys: String, CodingKey {
        case houseID = "houseId"
        case latitude, longitude, monthlyRent, deposit, occupancyTypes, location, genderPolicy, locationDescription, isPinned, moodTag, contractTerm
        case mainImageURL = "mainImgUrl"
        case isFull = "excludeFull"
    }
}
