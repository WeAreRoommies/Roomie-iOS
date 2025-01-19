//
//  HouseDetailModel.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import Foundation

// MARK: - HouseDetailModel

struct HouseDetailModel {
    let houseInfo: HouseInfo
    let rooms: [Room]
    let roommates: [Roommate]
}

// MARK: - House Info

struct HouseInfo {
    let houseId: Int
    let name: String
    let mainImgUrl: String
    let monthlyRent: String
    let deposit: String
    let location: String
    let occupancyTypes: String
    let occupancyStatus: String
    let genderPolicy: String
    let contractTerm: Int
    let moodTags: [String]
    let roomMood: String
    let groundRule: [String]
    let maintenanceCost: Int
    let isPinned: Bool
    let safetyLivingFacility: [String]
    let kitchenFacility: [String]
}

// MARK: - Room

struct Room {
    let roomId: Int
    let name: String
    let status: Bool
    let occupancyType: Int
    let gender: String
    let deposit: Int
    let prepaidUtilities: Int
    let monthlyRent: Int
    let contractPeriod: String
    let managementFee: String
}

// MARK: - Roommate

struct Roommate {
    let name: String
    let age: Int
    let job: String
    let mbti: String
    let sleepTime: String
    let activityTime: String
}

// MARK: - HouseInfoModel

struct HouseInfoData {
    let name: String
    let title: String
    let location: String
    let occupancyTypes: String
    let occupancyStatus: String
    let genderPolicy: String
    let contractTerm: Int
}
