//
//  HouseDetailResponseDTO.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import Foundation

struct HouseDetailResponseDTO: ResponseModelType {
    let houseInfo: HouseInfo
    let rooms: [Room]
}

struct HouseInfo: Codable {
    let houseID: Int
    let name, mainImageURL, monthlyRent, deposit: String
    let location, occupancyTypes, occupancyStatus, genderPolicy: String
    let contractTerm: Int
    let moodTags: [String]
    let roomMood: String
    let groundRule: [String]
    let isPinned: Bool
    let safetyLivingFacility, kitchenFacility: [String]

    enum CodingKeys: String, CodingKey {
        case houseID = "houseId"
        case name
        case mainImageURL = "mainImgUrl"
        case monthlyRent, deposit, location, occupancyTypes, occupancyStatus, genderPolicy, contractTerm
        case moodTags, roomMood, groundRule, isPinned, safetyLivingFacility, kitchenFacility
    }
}

struct Room: Codable {
    let roomID: Int
    let name: String
    let status, isTourAvailable: Bool
    let occupancyType: Int
    let gender: String
    let deposit: Int
    let monthlyRent: Int
    let contractPeriod: String?
    let managementFee: String

    enum CodingKeys: String, CodingKey {
        case roomID = "roomId"
        case name, status, isTourAvailable, occupancyType, gender, deposit
        case monthlyRent, contractPeriod, managementFee
    }
}
