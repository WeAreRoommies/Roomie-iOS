//
//  UserTargetType.swift
//  Roomie
//
//  Created by MaengKim on 1/21/25.
//

import Foundation

import Moya

enum UserTargetType {
    case fetchUserHomeData
    case fetchMypageData
}

extension UserTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchUserHomeData:
            return "/v1/users/home"
        case .fetchMypageData:
            return "/v1/users/mypage"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchUserHomeData:
            return .requestPlain
        case .fetchMypageData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
