//
//  WishListServiceProtocol.swift
//  Roomie
//
//  Created by MaengKim on 1/22/25.
//

import Foundation

protocol WishListServiceProtocol {
    func fetchWishListData() async throws -> BaseResponseBody<WishListResponseDTO>?
    
    func updatePinnedHouse(houseID: Int) async throws -> BaseResponseBody<PinWishResponseDTO>?
}
