//
//  AuthLogin.swift
//  Roomie
//
//  Created by 예삐 on 5/27/25.
//

struct AuthLoginRequestDTO: RequestModelType {
    let provider: String
    let accessToken: String
}
