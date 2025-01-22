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
    let roommates: [Roommate]
}

struct HouseInfo: Codable {
    let houseID: Int
    let name, mainImgURL, monthlyRent, deposit: String
    let location, occupancyTypes, occupancyStatus, genderPolicy: String
    let contractTerm: Int
    let moodTags: [String]
    let roomMood: String
    let groundRule: [String]
    let maintenanceCost: Int
    let isPinned: Bool
    let safetyLivingFacility, kitchenFacility: [String]

    enum CodingKeys: String, CodingKey {
        case houseID = "houseId"
        case name
        case mainImgURL = "mainImgUrl"
        case monthlyRent, deposit, location, occupancyTypes, occupancyStatus, genderPolicy, contractTerm
        case moodTags, roomMood, groundRule, maintenanceCost, isPinned, safetyLivingFacility, kitchenFacility
    }
}

struct Roommate: Codable {
    let name, age, job, mbti: String
    let sleepTime, activityTime: String
}

struct Room: Codable {
    let roomID: Int
    let name: String
    let status, isTourAvailable: Bool
    let occupancyType: Int
    let gender: String
    let deposit, prepaidUtilities, monthlyRent: Int
    let contractPeriod: String?
    let managementFee: String

    enum CodingKeys: String, CodingKey {
        case roomID = "roomId"
        case name, status, isTourAvailable, occupancyType, gender, deposit, prepaidUtilities
        case monthlyRent, contractPeriod, managementFee
    }
}
