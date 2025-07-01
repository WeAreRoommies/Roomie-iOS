//
//  MapRequestDTO.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

import Foundation

struct MapRequestDTO: RequestModelType {
    let address: String?
    let moodTag: [String]
    let depositRange, monthlyRentRange: MinMaxRange
    let genderPolicy: [String]
    let preferredDate: String?
    let occupancyTypes: [String]
    let contractPeriod: [Int]
    let latitude, longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case address = "location"
        case moodTag, depositRange, monthlyRentRange, genderPolicy
        case preferredDate, occupancyTypes, contractPeriod, latitude, longitude
    }
}

struct MinMaxRange: Codable {
    let min, max: Int
}
