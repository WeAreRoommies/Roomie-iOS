//
//  MyAccountTargetType.swift
//  Roomie
//
//  Created by 예삐 on 6/26/25.
//

import Foundation

import Moya

enum MyAccountTargetType {
    case fetchMyAccountData
}

extension MyAccountTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
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
