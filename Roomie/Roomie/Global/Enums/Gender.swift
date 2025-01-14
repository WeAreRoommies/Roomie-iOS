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
    
    var genderString: String {
        switch self {
        case .male:
            return "남성"
        case .female:
            return "여성"
        }
    }
}
