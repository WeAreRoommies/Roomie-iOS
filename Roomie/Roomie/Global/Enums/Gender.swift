//
//  Gender.swift
//  Roomie
//
//  Created by 김승원 on 1/14/25.
//

import Foundation

enum Gender {
    case male
    case female
    case none // 선택되지 않은 상태를 나타냄
    
    var genderString: String {
        switch self {
        case .male:
            return "남성"
        case .female:
            return "여성"
        case .none:
            return ""
        }
    }
}
