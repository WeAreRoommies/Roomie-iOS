//
//  MapsTargetType.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

import Foundation

import Moya

enum MapsTargetType {
    case fetchMapData(request: MapRequestDTO)
    case fetchMapSearchData(query: String)
}

extension MapsTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchMapData:
            return "/v1/maps/search"
        case .fetchMapSearchData:
            return "/v1/locations"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMapData: return .post
        case .fetchMapSearchData: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchMapData(let request):
            return .requestJSONEncodable(request)
        case .fetchMapSearchData(let query):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
