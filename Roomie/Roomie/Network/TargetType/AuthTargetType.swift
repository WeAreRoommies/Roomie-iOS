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
    case authReissue(refreshToken: String)
    case authLogout(refreshToken: String)
}

extension AuthTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1")!
    }
    
    var path: String {
        switch self {
        case .authLogin:
            return "/auth/oauth/login"
        case .authReissue:
            return "/auth/oauth/reissue"
        case .authLogout:
            return "/auth/oauth/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authLogin:
            return .post
        case .authReissue:
            return .post
        case .authLogout:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .authLogin(let request):
            return .requestJSONEncodable(request)
        case .authReissue:
            return .requestPlain
        case .authLogout:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .authLogin:
            return ["Content-Type": "application/json"]
        case .authReissue(let refreshToken), .authLogout(let refreshToken):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(refreshToken)"
            ]
        }
    }
}
