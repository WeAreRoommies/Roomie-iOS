//
//  MoodListModel.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import Foundation

struct MoodListRoom {
    let houseID: Int
    let monthlyRent: String
    let deposit: String
    let occupancyType: String
    let location: String
    let genderPolicy: String
    let locationDescription: String
    let isPinned: Bool
    let contractTerm: Int
    let mainImageURL: String
}

struct MoodInfo {
    let moodTag: String
}

extension MoodListRoom {
    static func moodListRoomData() -> [MoodListRoom] {
        return [
            MoodListRoom(
                houseID: 1,
                monthlyRent: "30~50",
                deposit: "200~300",
                occupancyType: "1,2인실",
                location: "서대문구 연희동",
                genderPolicy: "여성전용",
                locationDescription: "자이아파트",
                isPinned: false,
                contractTerm: 6,
                mainImageURL: ""
            ),
            MoodListRoom(
                houseID: 2,
                monthlyRent: "30~50",
                deposit: "200~300",
                occupancyType: "1,2,3인실",
                location: "서대문구 대현동",
                genderPolicy: "성별무관",
                locationDescription: "자이아파트",
                isPinned: true,
                contractTerm: 6,
                mainImageURL: ""
            )
        ]
    }
}

extension MoodInfo {
    static func mockMoodInfoData() -> [MoodInfo] {
        return [
            MoodInfo(moodTag: "#차분한")
        ]
    }
}
