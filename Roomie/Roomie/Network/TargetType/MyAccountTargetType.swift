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
}

extension MyAccountTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1/users")!
    }
    
    var path: String {
        switch self {
        case .fetchMyAccountData:
            return "/mypage/accountinfo"
        case .updateNameData:
            return "/name"
        case .updateNicknameData:
            return "/nickname"
        case .updateBirthDateData:
            return "/birthday"
        case .updatePhoneNumberData:
            return "/phonenumber"
        case .updateGenderData:
            return "/gender"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMyAccountData:
            return .get
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
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
