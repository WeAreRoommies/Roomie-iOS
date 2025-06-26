//
//  UserLocationResponseDTO.swift
//  Roomie
//
//  Created by MaengKim on 6/27/25.
//

import Foundation

struct UserLocationResponseDTO: ResponseModelType {
    let latitude: Double
    let longitude: Double
    let location: String
}
