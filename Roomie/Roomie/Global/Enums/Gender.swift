//
//  Gender.swift
//  Roomie
//
//  Created by 김승원 on 1/14/25.
//

import Foundation

enum Gender: String {
    case male = "MALE"
    case female = "FEMALE"
    case none = ""
    
    var apiValue: String { rawValue }
    
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
