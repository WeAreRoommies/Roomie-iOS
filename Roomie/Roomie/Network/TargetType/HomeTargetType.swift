//
//  HomeTargetType.swift
//  Roomie
//
//  Created by 예삐 on 1/23/25.
//

import Foundation

import Moya

enum HomeTargetType {
    case fetchUserHomeData
    case fetchLocationSearchData(query: String)
    case updatePinnedHouse(houseID: Int)
}

extension HomeTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1")!
    }
    
    var path: String {
        switch self {
        case .fetchUserHomeData:
            return "/users/home"
        case .fetchLocationSearchData:
            return "/locations"
        case .updatePinnedHouse(houseID: let houseID):
            return "/houses/\(houseID)/pins"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUserHomeData:
            return .get
        case .updatePinnedHouse:
            return .patch
        case .fetchLocationSearchData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchLocationSearchData(let query):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
