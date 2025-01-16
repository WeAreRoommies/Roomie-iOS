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
                location: "마포구 신촌동",
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
                monthlyRent: "25~40",
                deposit: "50~100",
                occupancyType: "4인실",
                location: "마포구 대흥동",
                genderPolicy: "여성전용",
                locationDescription: "서강하우스",
                isPinned: true,
                moodTag: "#깔끔한",
                contractTerm: 6,
                mainImageURL: ""
            ),
            MapModel(
                houseID: 3,
                x: 37.553909,
                y: 126.933960,
                monthlyRent: "50~80",
                deposit: "300~500",
                occupancyType: "1인실",
                location: "마포구 노고산동",
                genderPolicy: "여성전용",
                locationDescription: "신촌 맹그로브",
                isPinned: false,
                moodTag: "#활발한",
                contractTerm: 12,
                mainImageURL: ""
            ),
            MapModel(
                houseID: 4,
                x: 37.556304,
                y: 126.943263,
                monthlyRent: "30~50",
                deposit: "100~300",
                occupancyType: "2인실",
                location: "마포구 신촌동",
                genderPolicy: "남녀분리",
                locationDescription: "이화하우스",
                isPinned: true,
                moodTag: "#활발한",
                contractTerm: 12,
                mainImageURL: ""
            ),
            MapModel(
                houseID: 5,
                x: 37.547670,
                y: 126.942370,
                monthlyRent: "50~70",
                deposit: "50~100",
                occupancyType: "3인실",
                location: "마포구 대흥동",
                genderPolicy: "여성전용",
                locationDescription: "대흥하우스",
                isPinned: true,
                moodTag: "#조용한",
                contractTerm: 6,
                mainImageURL: ""
            )
        ]
    }
}
