//
//  HousesTargetType.swift
//  Roomie
//
//  Created by MaengKim on 1/22/25.
//

import Foundation

import Moya

enum HousesTargetType {
    case fetchHouseDetailData(houseID: Int)
    case fetchHouseDetailImagesData(houseID: Int)
    case fetchHouseDetailRoomsData(houseID: Int)
    case updatePinnedHouse(houseID: Int)
    case applyTour(request: TourRequestDTO, roomID: Int)
}

extension HousesTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseURL)/v1")!
    }
    
    var path: String {
        switch self {
        case .fetchHouseDetailData(houseID: let houseID):
            return "/houses/\(houseID)/details"
        case .fetchHouseDetailImagesData(houseID: let houseID):
            return "/houses/\(houseID)/details/images"
        case .fetchHouseDetailRoomsData(houseID: let houseID):
            return "/houses/\(houseID)/details/rooms"
        case .updatePinnedHouse(houseID: let houseID):
            return "/houses/\(houseID)/pins"
        case .applyTour(request: _, roomID: let roomID):
            return "/rooms/\(roomID)/tour-requests"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchHouseDetailData, .fetchHouseDetailImagesData, .fetchHouseDetailRoomsData: return .get
        case .updatePinnedHouse: return .patch
        case .applyTour: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchHouseDetailData, .updatePinnedHouse:
            return .requestPlain
        case .fetchHouseDetailImagesData, .fetchHouseDetailRoomsData:
            return .requestPlain
        case .applyTour(request: let request, roomID: _):
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
