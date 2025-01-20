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

struct House: Codable {
    let houseID: Int
    let x, y: Double
    let monthlyRent, deposit: String
    let occupancyTypes: String
    let location, genderPolicy, locationDescription: String
    let isPinned: Bool
    let moodTag: String
    let contractTerm: Int
    let mainImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case houseID = "houseId"
        case x, y, monthlyRent, deposit, occupancyTypes, location, genderPolicy, locationDescription, isPinned, moodTag, contractTerm
        case mainImageURL = "mainImgUrl"
    }
}
