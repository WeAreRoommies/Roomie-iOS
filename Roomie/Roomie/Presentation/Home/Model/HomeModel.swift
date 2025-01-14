//
//  HomeModel.swift
//  Roomie
//
//  Created by MaengKim on 1/15/25.
//

import Foundation

struct HomeModel {
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

struct UserInfo {
    let name: String
    let location: String
}
