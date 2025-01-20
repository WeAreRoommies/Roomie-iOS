//
//  MapRequestDTO.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

import Foundation

struct MapRequestDTO: RequestModelType {
    let location, moodTag: String
    let depositRange, monthlyRentRange: MinMaxRange
    let genderPolicy: [String]
    let preferredDate: String
    let occupancyType: [String]
    let contractPeriod: [Int]
}

struct MinMaxRange: Codable {
    let min, max: Int
}
