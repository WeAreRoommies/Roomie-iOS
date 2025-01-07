//
//  UIFont+.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit

extension UIFont {
    static func pretendard(_ style: Pretendard) -> UIFont {
        return UIFont(name: style.weight, size: style.size) ?? .systemFont(ofSize: style.size)
    }
    
    enum Pretendard {
        private static let scaleRatio: CGFloat = max(Screen.height(1), Screen.width(1))
        
        case heading1, heading2, heading3, heading4, heading5
        case title1, title2, title3
        case body1, body2, body3, body4, body5, body6
        case caption1, caption2, caption3
        
        var weight: String {
            switch self {
            case .heading1, .heading4:
                "Pretendard-Bold"
            case .heading2, .heading5, .title2, .body2, .body5, .caption2:
                "Pretendard-SemiBold"
            case .heading3, .title3, .body3, .body6, .caption3:
                "Pretendard-Medium"
            case .title1, .body1, .body4, .caption1:
                "Pretendard-Regular"
            }
        }
        
        var size: CGFloat {
            return defaultSize * Pretendard.scaleRatio
        }
        
        private var defaultSize: CGFloat {
            switch self {
            case .heading1, .heading2, .heading3: 20
            case .heading4, .heading5: 18
            case .title1, .title2, .title3: 16
            case .body1, .body2, .body3: 14
            case .body4, .body5, .body6: 12
            case .caption1, .caption2, .caption3: 10
            }
        }
        
        var tracking: CGFloat {
            switch self {
            case .heading1, .heading2, .heading3, .heading4, .heading5:
                CGFloat(-0.5) / 100 * size
            default:
                CGFloat(-1) / 100 * size
            }
        }
        
        var lineHeight: CGFloat {
            switch self {
            case .heading1, .heading2, .heading3: 28
            case .heading4, .heading5: 24
            case .title1, .title2, .title3: 22
            case .body1, .body2, .body3: 20
            case .body4, .body5, .body6:18
            case .caption1, .caption2, .caption3: 14
            }
        }
        
        var baselineOffset: CGFloat {
            if ProcessInfo.processInfo.isOperatingSystemAtLeast(
                OperatingSystemVersion(majorVersion: 16, minorVersion: 4, patchVersion: 0)) {
                (lineHeight - size) / 2
            } else {
                (lineHeight - size) / 4
            }
        }
    }
}
