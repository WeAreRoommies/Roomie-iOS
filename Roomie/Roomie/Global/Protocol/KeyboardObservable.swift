//
//  KeyboardObservable.swift
//  Roomie
//
//  Created by 김승원 on 1/14/25.
//

import UIKit

/// Keyboard Event를 설정해주는 Protocol입니다.
protocol KeyboardObservable where Self: UIViewController {
    /// 키보드 이벤트를 받을 때 움직일 UIView입니다.
    var transformView: UIView { get }
    func setKeyboardObserver()
}

extension KeyboardObservable where Self: UIViewController {
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: OperationQueue.main
        ) { [weak self] notification in
            self?.keyboardWillAppear(notification)
        }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: OperationQueue.main
        ) { [weak self] notification in
            self?.keyboardWillDisappear(notification)
        }
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default
            .removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default
            .removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func keyboardWillAppear(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = transformView.convert(
            currentTextField.frame,
            from: currentTextField.superview
        )
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textFieldTopY = convertedTextFieldFrame.origin.y
            let newFrame = textFieldTopY - keyboardTopY/1.25
            transformView.frame.origin.y -= newFrame
        }
    }
    
    private func keyboardWillDisappear(_ sender: Notification) {
        if transformView.frame.origin.y != 0 {
            transformView.frame.origin.y = 0
        }
    }
}
