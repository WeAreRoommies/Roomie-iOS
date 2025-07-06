//
//  BirthDateRequestDTO.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import Foundation

struct BirthDateRequestDTO: RequestModelType {
    let birthDate: String
    
    enum CodingKeys: String, CodingKey {
        case birthDate = "birthDay"
    }
}
