//
//  TokenError.swift
//  Roomie
//
//  Created by 김승원 on 6/6/25.
//

import Foundation

enum TokenError: Error {
    case noRefreshToken
    case reissueFailed
    case refreshTokenExpired
    case userNotFound
    case unknownError(error: Error)
    
    var description: String {
        switch self {
        case .noRefreshToken:
            return "저장된 refreshToken이 없습니다."
        case .reissueFailed:
            return "토큰 재발급 요청에 실패했습니다."
        case .refreshTokenExpired:
            return "refresthToken이 만료되었습니다."
        case .userNotFound:
            return "해당 유저를 찾을 수 없습니다."
        case .unknownError:
            return "알 수 없는 에러가 발생했습니다."
        }
    }
}
