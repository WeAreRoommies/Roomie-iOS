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

struct Location: Codable, Hashable {
    let latitude, longitude: Double
    let location, address, roadAddress: String
}
