//
//  Gender.swift
//  Roomie
//
//  Created by 김승원 on 1/14/25.
//

import Foundation

enum Gender: String {
    case male
    case female
    case none
    
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
    
    var apiValue: String {
        switch self {
        case .male:
            return "MALE"
        case .female:
            return "FEMALE"
        case .none: 
            return ""
        }
    }
}
