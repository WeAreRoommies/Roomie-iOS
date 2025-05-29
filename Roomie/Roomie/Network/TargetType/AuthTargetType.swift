//
//  AuthTargetType.swift
//  Roomie
//
//  Created by 예삐 on 5/27/25.
//

import Foundation

import Moya

enum AuthTargetType {
    case authLogin(request: AuthLoginRequestDTO)
}

extension AuthTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1")!
    }
    
    var path: String {
        switch self {
        case .authLogin:
            return "/auth/oauth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authLogin:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .authLogin(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
