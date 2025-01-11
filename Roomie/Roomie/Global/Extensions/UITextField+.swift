//
//  UITextField+.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit

extension UITextField {
    func addPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let left {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 0))
            leftViewMode = .always
        }
        
        if let right {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 0))
            rightViewMode = .always
        }
    }
    
    func setText(
        placeholder: String = "",
        placeholderColor: UIColor = .grayscale1,
        textColor: UIColor,
        backgroundColor: UIColor,
        style: UIFont.Pretendard
    ) {
        self.font = UIFont.pretendard(style)
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeholderColor,
                .font: UIFont.pretendard(style),
                .kern: style.tracking
            ]
        )
        self.attributedText = .pretendardString(style: style)
    }
    
    func setLayer(borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat) {
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
    }
    
    func setAutoType(
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no
    ) {
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
    }
}
