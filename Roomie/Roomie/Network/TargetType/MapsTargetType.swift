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
    case updatePinnedHouse(houseID: Int)
}

extension MapsTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1")!
    }
    
    var path: String {
        switch self {
        case .fetchMapData:
            return "/maps/search"
        case .fetchMapSearchData:
            return "/locations"
        case .updatePinnedHouse(houseID: let houseID):
            return "/houses/\(houseID)/pins"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMapData: return .post
        case .fetchMapSearchData: return .get
        case .updatePinnedHouse: return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchMapData(let request):
            return .requestJSONEncodable(request)
        case .fetchMapSearchData(let query):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding.queryString)
        case .updatePinnedHouse:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
