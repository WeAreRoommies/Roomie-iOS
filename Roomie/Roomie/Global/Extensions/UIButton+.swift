//
//  UIButton+.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit

extension UIButton {
    func setTitle(_ title: String, style: UIFont.Pretendard, color: UIColor) {
        setAttributedTitle(.pretendardString(title, style: style), for: .normal)
        setTitleColor(color, for: .normal)
    }
    
    func setLayer(borderWidth: CGFloat = 0, borderColor: UIColor, cornerRadius: CGFloat) {
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
    }
    
    /// 버튼에 밑줄을 추가할 때
    func addUnderline() {
        let attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
        attributedString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
