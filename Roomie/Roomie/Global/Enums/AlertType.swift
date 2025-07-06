//
//  AlertType.swift
//  Roomie
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

enum AlertType {
    case logout
    case signout
    
    var title: String {
        switch self {
        case .logout:
            return "로그아웃 하시겠어요?"
        case .signout:
            return "정말 탈퇴하시겠어요?"
        }
    }
    
    var message: String {
        switch self {
        case .logout:
            return "로그아웃 시, 다시 로그인해야 앱을 사용할 수 있어요."
        case .signout:
            return "탈퇴 시, 모든 정보가 삭제되며 복구할 수 없어요."
        }
    }
    
    var isCancelButtonEnabled: Bool {
        switch self {
        case .logout, .signout:
            return true
        }
    }
    
    var isDestructiveButtonEnabled: Bool {
        switch self {
        case .logout:
            return false
        case .signout:
            return true
        }
    }
}
