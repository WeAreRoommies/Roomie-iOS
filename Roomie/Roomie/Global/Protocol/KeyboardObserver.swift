//
//  KeyboardObserver.swift
//  Roomie
//
//  Created by 김승원 on 1/14/25.
//

import UIKit

/// Keyboard Observer를 추가하는 프로토콜입니다.
///
/// setKeyboardObserver() - viewWillAppear()에서 호출해야 합니다.
/// removeKeyboardObserver() - viewWillDisappear()에서 호출해야 합니다.
///
/// keyboardWillShow(notification: Notification) - 키보드가 올라올 때 호출 되는 메서드
/// keyboardWillHide(notificationㅗ: Notification) - 키보드가 내려갈 때 호출 되는 메서드
///
protocol KeyboardObserver: AnyObject {
    func setKeyboardObserver()
    func removeKeyboardObserver()
    func keyboardWillShow(notification: Notification)
    func keyboardWillHide(notification: Notification)
}

extension KeyboardObserver where Self: UIViewController {
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main) { [weak self] notification in
                self?.keyboardWillShow(notification: notification)
            }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main) { [weak self] notification in
                self?.keyboardWillHide(notification: notification)
            }
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
