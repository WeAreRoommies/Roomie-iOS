//
//  MyAccountResponseDTO.swift
//  Roomie
//
//  Created by 예삐 on 6/6/25.
//

import Foundation

struct MyAccountResponseDTO: ResponseModelType {
    let nickname, socialType: String
    let name, birthDate, phoneNumber, gender: String?
}
