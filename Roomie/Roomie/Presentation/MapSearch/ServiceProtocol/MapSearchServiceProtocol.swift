//
//  MapSearchServiceProtocol.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

import Foundation

protocol MapSearchServiceProtocol {
    func fetchMapSearchData(query: String) async throws -> BaseResponseBody<MapSearchResponseDTO>?
}
