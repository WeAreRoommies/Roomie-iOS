//
//  MapServiceProtocol.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

import Foundation

protocol MapServiceProtocol {
    func fetchMapData(request: MapRequestDTO) async throws -> BaseResponseBody<MapResponseDTO>?
}
