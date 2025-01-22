//
//  MoodListServiceProtocol.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import Foundation

protocol MoodListServiceProtocol {
    func fetchMoodListData(moodTag: String) async throws -> BaseResponseBody<MoodListResponseDTO>?
}
