//
//  HomeServiceProtocol.swift
//  Roomie
//
//  Created by MaengKim on 1/21/25.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchHomeData() async throws -> BaseResponseBody<HomeResponseDTO>?
    
    // TODO: 찜 API 추가
}
