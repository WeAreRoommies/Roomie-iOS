//
//  HouseDetailImagesResponseDTO.swift
//  Roomie
//
//  Created by 김승원 on 1/23/25.
//

import Foundation

struct HouseDetailImagesResponseDTO: ResponseModelType {
    let images: HouseDetailImages
}

struct HouseDetailImages: Codable {
    let mainImageURL: String
    let mainImageDescription: String
    let facilityImageUrls: [String]
    let facilityImageDescription: String
    let floorImageURL: String

    enum CodingKeys: String, CodingKey {
        case mainImageURL = "mainImgUrl"
        case mainImageDescription = "mainImgDescription"
        case facilityImageUrls = "facilityImgUrls"
        case facilityImageDescription = "facilityImgDescription"
        case floorImageURL = "floorImgUrl"
    }
}
