//
//  MyAccountServiceProtocol.swift
//  Roomie
//
//  Created by 예삐 on 6/26/25.
//

import Foundation

protocol MyAccountServiceProtocol {
    func fetchMyAccountData() async throws -> BaseResponseBody<MyAccountResponseDTO>?
    func updateNameData(request: NameRequestDTO) async throws -> BaseResponseBody<NameResponseDTO>?
}
