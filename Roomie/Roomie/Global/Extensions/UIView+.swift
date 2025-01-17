//
//  UIView+.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
    
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    func setGradient(for style: Gradient) {
        let gradientLayer = CAGradientLayer.gradientLayer(for: style, in: bounds)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
