//
//  ToastType.swift
//  Roomie
//
//  Created by 김승원 on 6/12/25.
//

import Foundation

enum ToastType {
    case loginSuccess
    case sessionExpired
    case serverError
    case requestFailed
    case unexpectedError
    
    var message: String {
        switch self {
        case .loginSuccess:
            return "로그인에 성공했어요"
        case .sessionExpired:
            return "세션이 만료되었어요. 다시 로그인해주세요"
        case .serverError:
            return "서버 오류입니다. 다시 시도해주세요"
        case .requestFailed:
            return "요청에 실패했습니다. 잠시 후 다시 시도해주세요"
        case .unexpectedError:
            return "예기치 못한 오류가 발생했어요"
        }
    }
    
    var bottomInset: CGFloat {
        switch self {
        case .sessionExpired:
            return Screen.height(20)
        case .loginSuccess, .serverError, .requestFailed, .unexpectedError:
            return Screen.height(100)
        }
    }
}
