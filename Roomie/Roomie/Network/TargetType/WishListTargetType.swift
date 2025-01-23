//
//  WishListTargetType.swift
//  Roomie
//
//  Created by 예삐 on 1/24/25.
//

import Foundation

import Moya

enum WishListTargetType {
    case fetchWishLishData
    case updatePinnedHouse(houseID: Int)
}

extension WishListTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1")!
    }
    
    var path: String {
        switch self {
        case .fetchWishLishData:
            return "/houses/pins"
        case .updatePinnedHouse(houseID: let houseID):
            return "/houses/\(houseID)/pins"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchWishLishData: return .get
        case .updatePinnedHouse: return .patch
        }
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
