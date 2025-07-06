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
    case updateUserLocation(latitude: Double, longitude: Double, location: String)
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
        case .updateUserLocation:
            return "users/location"
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
        case .updateUserLocation:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchLocationSearchData(let query):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding.queryString)
        case .updateUserLocation(let lat, let lng, let location):
            return .requestParameters(
                parameters: ["latitude": lat, "longitude": lng, "location": location],
                encoding: JSONEncoding.default
            )
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
