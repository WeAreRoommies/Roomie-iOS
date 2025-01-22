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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchWishLishData:
            return .get
        case .fetchHouseDetailData(houseID: let houseID):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchWishLishData:
            return .requestPlain
        case .fetchHouseDetailData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
