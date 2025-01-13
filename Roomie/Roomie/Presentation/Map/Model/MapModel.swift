//
//  MapModel.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import Foundation

struct MapModel {
    let houseID: Int
    let x: CGFloat
    let y: CGFloat
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

struct MarkerInfo {
    let houseID: Int
    let x: CGFloat
    let y: CGFloat
}

struct MarkerDetailInfo {
    let monthlyRent: String
    let deposit: String
    let occupancyType: String
    let location: String
    let genderPolicy: String
    let locationDescription: String
    let isPinned: Bool
    let moodTag: String
    let contractTerm: Int
}

extension MapModel {
    static func mockMapData() -> [MapModel] {
        return [
            MapModel(
                houseID: 1,
                x: 37.555184166,
                y: 126.936910322,
                monthlyRent: "35~50",
                deposit: "200~300",
                occupancyType: "2인실",
                location: "서대문구 신촌동",
                genderPolicy: "여성전용",
                locationDescription: "신촌하우스",
                isPinned: true,
                moodTag: "#차분한",
                contractTerm: 6,
                mainImageURL: ""
            ),
            MapModel(
                houseID: 2,
                x: 37.552502661,
                y: 126.934998613,
                monthlyRent: "25~30",
                deposit: "50~100",
                occupancyType: "4인실",
                location: "서대문구 대흥동",
                genderPolicy: "여성전용",
                locationDescription: "서강하우스",
                isPinned: true,
                moodTag: "#활발한",
                contractTerm: 6,
                mainImageURL: ""
            )
        ]
    }
}
