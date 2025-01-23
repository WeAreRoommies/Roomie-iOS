//
//  HousesTargetType.swift
//  Roomie
//
//  Created by MaengKim on 1/22/25.
//

import Foundation

import Moya

enum HousesTargetType {
    case fetchWishLishData
    case fetchHouseDetailData(houseID: Int)
    case fetchMoodListData(moodTag: String)
    case updatePinnedHouse(houseID: Int)
    case fetchHouseDetailImagesData(houseID: Int)
    case fetchHouseDetailRoomsData(houseID: Int)
    case applyTour(request: TourRequestDTO, roomID: Int)
}

extension HousesTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1")!
    }
    
    var path: String {
        switch self {
        case .fetchMoodListData:
            return "/houses"
        case .fetchWishLishData:
            return "/houses/pins"
        case .fetchHouseDetailData(houseID: let houseID):
            return "/houses/\(houseID)/details"
        case .updatePinnedHouse(houseID: let houseID):
            return "/houses/\(houseID)/pins"
        case .fetchHouseDetailImagesData(houseID: let houseID):
            return "/houses/\(houseID)/details/images"
        case .fetchHouseDetailRoomsData(houseID: let houseID):
            return "/houses/\(houseID)/details/rooms"
        case .applyTour(request: let request, roomID: let roomID):
            return "/rooms/\(roomID)/tour-requests"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchWishLishData, .fetchHouseDetailData: return .get
        case .fetchMoodListData, .fetchHouseDetailImagesData, .fetchHouseDetailRoomsData: return .get
        case .updatePinnedHouse: return .patch
        case .applyTour: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchWishLishData, .fetchHouseDetailData, .updatePinnedHouse:
            return .requestPlain
        case .fetchHouseDetailImagesData, .fetchHouseDetailRoomsData:
            return .requestPlain
        case .fetchMoodListData(moodTag: let moodTag):
            return .requestParameters(
                parameters: ["moodTag": moodTag],
                encoding: URLEncoding.queryString
            )
        case .applyTour(request: let request, roomID: let roomID):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
