//
//  HousesTargetType.swift
//  Roomie
//
//  Created by MaengKim on 1/22/25.
//

import Foundation

import Moya

enum HousesTargetType {
    case fetchWishLishData
    case fetchHouseDetailData(houseID: Int)
    case fetchMoodListData(moodTag: String)
}

extension HousesTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1/houses")!
    }
    
    var path: String {
        switch self {
        case .fetchWishLishData:
            return "/pins"
        case .fetchHouseDetailData(houseID: let houseID):
            return "/\(houseID)/details"
        case .fetchMoodListData:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchWishLishData: return .get
        case .fetchHouseDetailData: return .get
        case .fetchMoodListData: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchWishLishData:
            return .requestPlain
        case .fetchHouseDetailData:
            return .requestPlain
        case .fetchMoodListData(moodTag: let moodTag):
            return .requestParameters(
                parameters: ["moodTag":moodTag],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
