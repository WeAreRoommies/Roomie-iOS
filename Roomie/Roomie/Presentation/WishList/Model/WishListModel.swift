//
//  WishListModel.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import Foundation

struct WishListRoom {
    let houseID: Int
    let monthlyRent: String
    let deposit: String
    let occupancyType: String
    let location: String
    let genderPolicy: String
    let locationDescription: String
    let isPinned: Bool
    let moodTag: String
    let contractTerm: Int
    let mainImageURL: String
}

extension WishListRoom {
    static func mockHomeData() -> [WishListRoom] {
        return [
            WishListRoom(
                houseID: 1,
                monthlyRent: "30~50",
                deposit: "200~300",
                occupancyType: "1,2인실",
                location: "서대문구 연희동",
                genderPolicy: "여성전용",
                locationDescription: "자이아파트",
                isPinned: false,
                moodTag: "#차분한",
                contractTerm: 6,
                mainImageURL: ""
            ),
            WishListRoom(
                houseID: 2,
                monthlyRent: "30~50",
                deposit: "200~300",
                occupancyType: "1,2,3인실",
                location: "서대문구 대현동",
                genderPolicy: "성별무관",
                locationDescription: "자이아파트",
                isPinned: true,
                moodTag: "#활기찬",
                contractTerm: 6,
                mainImageURL: ""
            )
        ]
    }
}
