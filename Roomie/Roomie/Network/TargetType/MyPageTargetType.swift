//
//  UserTargetType.swift
//  Roomie
//
//  Created by MaengKim on 1/21/25.
//

import Foundation

import Moya

enum MyPageTargetType {
    case fetchMyPageData
    case fetchMyAccountData
}

extension MyPageTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchMyPageData:
            return "/v1/users/mypage"
        case .fetchMyAccountData:
            return "/v1/users/mypage/accountinfo"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
