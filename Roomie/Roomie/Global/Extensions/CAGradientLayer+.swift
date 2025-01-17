//
//  CAGradientLayer.swift
//  Roomie
//
//  Created by MaengKim on 1/17/25.
//

import UIKit

extension CAGradientLayer {
    static func gradientLayer(for style: Gradient, in frame: CGRect) -> Self {
        let layer = Self()
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = colors(for: style)
        layer.frame = frame
        return layer
    }
    
    static func colors(for style: Gradient) -> [CGColor] {
        let beginColor: UIColor
        let endColor: UIColor
        
        switch style {
        case .home:
            beginColor = UIColor(hexCode: "#FAFAFA")
            endColor = UIColor(hexCode: "#626CF6")
        case .moodList:
            beginColor = UIColor(hexCode: "#EEEFFE")
            endColor = UIColor(hexCode: "#FFFFFF")
        }
        return [beginColor.cgColor, endColor.cgColor]
    }
}
