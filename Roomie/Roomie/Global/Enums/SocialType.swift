//
//  SocialType.swift
//  Roomie
//
//  Created by 예삐 on 6/5/25.
//

enum SocialType {
    case kakao
    case apple
    
    var socialTypeString: String {
        switch self {
        case .kakao:
            return "KAKAO"
        case .apple:
            return "APPLE"
        }
    }
}
