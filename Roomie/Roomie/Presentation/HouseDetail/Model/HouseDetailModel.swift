//
//  HouseDetailModel.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import Foundation

// MARK: - HouseDetailModel

struct HouseDetailModel: Hashable {
    let id = UUID()
    let houseInfo: HouseInfo
    let rooms: [Room]
    let roommates: [Roommate]
}

// MARK: - House Info

struct HouseInfo: Hashable {
    let id = UUID()
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

struct Room: Hashable {
    let id = UUID()
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

struct Roommate: Hashable {
    let id = UUID()
    let name: String
    let age: Int
    let job: String
    let mbti: String
    let sleepTime: String
    let activityTime: String
}

// MARK: - Mock Data

extension HouseDetailModel {
    static func mockData() -> [HouseDetailModel] {
        return [
            HouseDetailModel(
                houseInfo: HouseInfo(
                    houseId: 123,
                    name: "루미 100호점(이대역)",
                    mainImgUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDA1MTJfNDMg%2FMDAxNzE1NTA2ODczMjAy.sMMENVnkUx2jpoJtEZtddKoIRSVyYEjRxGA81vWPlPMg.HCWsC4FSH2up1BJJGDeDzwzPFTxa7M3Qv1bBb0YS7eAg.JPEG%2FPDM_0612.jpg&type=sc960_832",
                    monthlyRent: "43~50",
                    deposit: "90~100",
                    location: "서대문구 연희동",
                    occupancyTypes: "1,2,3인실",
                    occupancyStatus: "2/5",
                    genderPolicy: "여성 전용",
                    contractTerm: 3,
                    moodTags: ["#차분한", "#유쾌한", "#경쾌한"],
                    roomMood: "전반적으로 조용하고 깔끔한 환경을 선호하는 아침형 룸메이트들이에요.",
                    groundRule: ["요리 후 바로 설거지해요", "청소는 주3회 돌아가면서 해요"],
                    maintenanceCost: 300000,
                    isPinned: true,
                    safetyLivingFacility: ["소화기", "소화기"],
                    kitchenFacility: ["주걱", "밥솥"]
                ),
                rooms: [
                    Room(
                        roomId: 1,
                        name: "1A 싱글침대",
                        status: true,
                        occupancyType: 2,
                        gender: "여성",
                        deposit: 5000000,
                        prepaidUtilities: 100000,
                        monthlyRent: 500000,
                        contractPeriod: "24-12-20",
                        managementFee: "1/n"
                    ),
                    Room(
                        roomId: 2,
                        name: "1B 싱글침대",
                        status: false,
                        occupancyType: 1,
                        gender: "여성",
                        deposit: 5000000,
                        prepaidUtilities: 100000,
                        monthlyRent: 500000,
                        contractPeriod: "24-12-20",
                        managementFee: "1/n"
                    )
                ],
                roommates: [
                    Roommate(
                        name: "1A 싱글침대",
                        age: 23,
                        job: "대학생",
                        mbti: "ENFP",
                        sleepTime: "21:00-21:00",
                        activityTime: "21:00-21:00"
                    ),
                    Roommate(
                        name: "1A 싱글침대",
                        age: 23,
                        job: "대학생",
                        mbti: "ENFP",
                        sleepTime: "21:00-21:00",
                        activityTime: "21:00-21:00"
                    )
                ]
            )
        ]
    }
}
