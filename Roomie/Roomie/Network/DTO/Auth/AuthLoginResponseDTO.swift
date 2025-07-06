//
//  AuthLoginResponseDTO.swift
//  Roomie
//
//  Created by 예삐 on 5/27/25.
//

struct AuthLoginResponseDTO: ResponseModelType {
    let accessToken: String
    let refreshToken: String
}
