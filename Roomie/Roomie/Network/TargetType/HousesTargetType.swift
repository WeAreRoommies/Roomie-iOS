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
}

extension HousesTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchWishLishData:
            return "/v1/houses/pins"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchWishLishData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchWishLishData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
