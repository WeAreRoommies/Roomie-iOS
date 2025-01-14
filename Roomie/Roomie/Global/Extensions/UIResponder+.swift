//
//  UIResponder.swift
//  Roomie
//
//  Created by 김승원 on 1/14/25.
//

import UIKit

extension UIResponder {
    
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    /// 현재 응답 받는 UI를 반환합니다. (UITextField, UITextView)
    static var currentResponder: UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc
    private func _trap() {
        Static.responder = self
    }
}
