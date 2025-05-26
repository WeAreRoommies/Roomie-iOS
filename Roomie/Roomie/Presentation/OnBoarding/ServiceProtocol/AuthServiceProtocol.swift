//
//  AuthServiceProtocol.swift
//  Roomie
//
//  Created by 예삐 on 5/27/25.
//

import Foundation

protocol AuthServiceProtocol {
    func authLogin(request: AuthLoginRequestDTO) async throws -> BaseResponseBody<AuthLoginResponseDTO>?
}
