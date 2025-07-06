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
    case updateNicknameData(request: NicknameRequestDTO)
    case updateBirthDateData(request: BirthDateRequestDTO)
    case updatePhoneNumberData(request: PhoneNumberRequestDTO)
    case updateGenderData(request: GenderRequestDTO)
    case authLogout(refreshToken: String)
    case authSignout(refreshToken: String)
}

extension MyAccountTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1")!
    }
    
    var path: String {
        switch self {
        case .fetchMyAccountData:
            return "/users/mypage/accountinfo"
        case .updateNameData:
            return "/users/name"
        case .updateNicknameData:
            return "/users/nickname"
        case .updateBirthDateData:
            return "/users/birthday"
        case .updatePhoneNumberData:
            return "/users/phonenumber"
        case .updateGenderData:
            return "/users/gender"
        case .authLogout:
            return "/auth/oauth/logout"
        case .authSignout:
            return "/users/delete"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMyAccountData:
            return .get
        case .authLogout, .authSignout:
            return .delete
        default:
            return .patch
        }
        
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchMyAccountData:
            return .requestPlain
        case .updateNameData(let request):
            return .requestJSONEncodable(request)
        case .updateNicknameData(let request):
            return .requestJSONEncodable(request)
        case .updateBirthDateData(let request):
            return .requestJSONEncodable(request)
        case .updatePhoneNumberData(let request):
            return .requestJSONEncodable(request)
        case .updateGenderData(let request):
            return .requestJSONEncodable(request)
        case .authLogout, .authSignout:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .authLogout(let refreshToken), .authSignout(let refreshToken):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(refreshToken)"
            ]
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
