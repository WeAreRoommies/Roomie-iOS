//
//  Screen.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit

enum Screen {
    static func width(_ value: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let designWidth: CGFloat = 375.0
        return screenWidth / designWidth * value
    }
    
    static func height(_ value: CGFloat) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let designHeight: CGFloat = 812.0
        return screenHeight / designHeight * value
    }
}
