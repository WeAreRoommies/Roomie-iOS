//
//  NSAttributedString+.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit

extension NSAttributedString {
    static func pretendardString(
        _ text: String = "",
        style: UIFont.Pretendard
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = style.lineHeight
        paragraphStyle.minimumLineHeight = style.lineHeight
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.pretendard(style),
            .kern: style.tracking,
            .baselineOffset: style.baselineOffset
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}
