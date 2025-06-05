//
//  MoodListTargetType.swift
//  Roomie
//
//  Created by 예삐 on 1/24/25.
//

import Foundation

import Moya

enum MoodListTargetType {
    case fetchMoodListData(moodTag: String)
    case updatePinnedHouse(houseID: Int)
}

extension MoodListTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1")!
    }
    
    var path: String {
        switch self {
        case .fetchMoodListData:
            return "/houses"
        case .updatePinnedHouse(houseID: let houseID):
            return "/houses/\(houseID)/pins"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMoodListData: return .get
        case .updatePinnedHouse: return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchMoodListData(moodTag: let moodTag):
            return .requestParameters(
                parameters: ["moodTag": moodTag],
                encoding: URLEncoding.queryString
            )
        case .updatePinnedHouse:
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
