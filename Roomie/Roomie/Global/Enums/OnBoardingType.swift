//
//  OnBoardingType.swift
//  Roomie
//
//  Created by MaengKim on 5/20/25.
//

import UIKit

enum OnBoardingType: CaseIterable {
    case infoStep
    case filterStep
    case hostStep
    case login
    
    static var onBoardingCases: [OnBoardingType] {
        return [.infoStep, .filterStep, .hostStep]
    }
    
    var isLogin: Bool {
        return self == .login
    }
    
    var title: String? {
        switch self {
        case .infoStep:
            return "잘 맞는 셰어하우스를 찾아봐요!"
        case .filterStep:
            return "조건에 맞는 곳만 찾아봐요"
        case .hostStep:
            return "투어신청 후 계약해요"
        case .login:
            return nil
        }
    }
    
    var subTitle: String? {
        switch self {
        case .infoStep:
            return "셰어하우스의 생활 규칙, 방 분위기 등의\n정보를 확인할 수 있어요"
        case .filterStep:
            return "필터를 통해 찾고자 하는 조건의\n셰어하우스만 볼 수 있어요"
        case .hostStep:
            return "호스트와 연락해 입주 투어 날짜를 정하고\n문의사항 주고받을 수 있어요"
        case .login:
            return nil
        }
    }
    
    var onBoardingViewImage: UIImage? {
        switch self {
        case .infoStep:
            return UIImage(named: "img_profile")
        case .filterStep:
            return UIImage(named: "img_profile")
        case .hostStep:
            return UIImage(named: "img_profile")
        case .login:
            return nil
        }
    }
}
