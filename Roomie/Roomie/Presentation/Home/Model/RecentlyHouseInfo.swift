//
//  RecentlyHouseInfo.swift
//  Roomie
//
//  Created by MaengKim on 1/22/25.
//

import Foundation

struct RecentlyHouse: Hashable {
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
