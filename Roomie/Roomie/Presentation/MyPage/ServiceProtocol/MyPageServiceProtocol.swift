//
//  MyPageServiceProtocol.swift
//  Roomie
//
//  Created by 예삐 on 1/22/25.
//

import Foundation

protocol MyPageServiceProtocol {
    func fetchMyPageData() async throws -> BaseResponseBody<MyPageResponseDTO>?
}
