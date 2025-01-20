//
//  MapSearchResponseDTO.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

import Foundation

struct MapSearchResponseDTO: ResponseModelType {
    let locations: [Location]
}

struct Location: Codable {
    let x, y: Double
    let location, address, roadAddress: String
}
