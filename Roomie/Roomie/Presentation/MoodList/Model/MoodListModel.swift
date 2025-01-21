//
//  MoodListModel.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import Foundation

struct MoodListHouse: Hashable {
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

extension MoodListHouse {
    static func calmListRoomData() -> [MoodListHouse] {
        return [
            MoodListHouse(
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
            MoodListHouse(
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

extension MoodListHouse {
    static func livelyListRoomData() -> [MoodListHouse] {
        return [
            MoodListHouse(
                houseID: 3,
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
            MoodListHouse(
                houseID: 4,
                monthlyRent: "30~50",
                deposit: "200~300",
                occupancyType: "1,2,3인실",
                location: "서대문구 대현동",
                genderPolicy: "성별무관",
                locationDescription: "자이아파트",
                isPinned: true,
                contractTerm: 6,
                mainImageURL: ""
            ),
            MoodListHouse(
                houseID: 5,
                monthlyRent: "30~50",
                deposit: "200~300",
                occupancyType: "1,2,3인실",
                location: "서대문구 대현동",
                genderPolicy: "성별무관",
                locationDescription: "자이아파트",
                isPinned: true,
                contractTerm: 6,
                mainImageURL: ""
            ),
            MoodListHouse(
                houseID: 6,
                monthlyRent: "30~50",
                deposit: "200~300",
                occupancyType: "1,2,3인실",
                location: "서대문구 대현동",
                genderPolicy: "성별무관",
                locationDescription: "자이아파트",
                isPinned: true,
                contractTerm: 6,
                mainImageURL: ""
            ),
            MoodListHouse(
                houseID: 7,
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

extension MoodListHouse {
    static func neatListRoomData() -> [MoodListHouse] {
        return [
            MoodListHouse(
                houseID: 8,
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
            MoodListHouse(
                houseID: 9,
                monthlyRent: "30~50",
                deposit: "200~300",
                occupancyType: "1,2,3인실",
                location: "서대문구 대현동",
                genderPolicy: "성별무관",
                locationDescription: "자이아파트",
                isPinned: true,
                contractTerm: 6,
                mainImageURL: ""
            ),
            MoodListHouse(
                houseID: 10,
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
