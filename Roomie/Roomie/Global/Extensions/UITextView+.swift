//
//  UITextView+.swift
//  Roomie
//
//  Created by 김승원 on 1/15/25.
//

import UIKit
import Combine

extension UITextView {
    func addInset(
        top: CGFloat,
        left: CGFloat,
        bottom: CGFloat,
        right: CGFloat
    ) {
        textContainerInset = UIEdgeInsets(
            top: top,
            left: left,
            bottom: bottom,
            right: right
        )
        contentInset = .zero
    }
    
    func setText(
        textColor: UIColor,
        backgroundColor: UIColor,
        style: UIFont.Pretendard
    ) {
        self.font = UIFont.pretendard(style)
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    func setLayer(
        borderWidth: CGFloat,
        borderColor: UIColor,
        cornerRadius: CGFloat
    ) {
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

extension UITextView {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextView)?.text }
            .eraseToAnyPublisher()
    }
    
    var didBeginEditingPublisher: AnyPublisher<Void, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidBeginEditingNotification, object: self)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    var didEndEditingPublisher: AnyPublisher<Void, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidEndEditingNotification, object: self)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
