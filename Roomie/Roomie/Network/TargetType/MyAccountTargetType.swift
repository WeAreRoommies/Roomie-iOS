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
    case updateNameData(request: NameRequestDTO)
}

extension MyAccountTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchMyAccountData:
            return "/v1/users/mypage/accountinfo"
        case .updateNameData:
            return "/v1/users/name"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMyAccountData:
            return .get
        case .updateNameData:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchMyAccountData:
            return .requestPlain
        case .updateNameData(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
