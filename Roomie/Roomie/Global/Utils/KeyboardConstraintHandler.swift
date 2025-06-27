//
//  KeyboardConstraintHandler.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import UIKit

import SnapKit

/// 키보드 높이에 따라 Constraint를 움직여주는 범용 매니저
final class KeyboardConstraintHandler {
    struct Adjustment {
        /// 변경할 제약
        let constraint: Constraint
        /// 키보드 없을 때의 기본 값
        let defaultInset: CGFloat
    }
    
    private weak var containerView: UIView?
    private var adjustments: [Adjustment]
    
    init(containerView: UIView, adjustments: [Adjustment]) {
        self.containerView = containerView
        self.adjustments = adjustments
    }
    
    func startObserving() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func stopObserving() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func keyboardWillShow(_ note: Notification) {
        guard
            let containerView = containerView,
            let info = note.userInfo,
            let frame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double)
        else { return }
        
        let keyboardHeight = frame.height - containerView.safeAreaInsets.bottom
        
        adjustments.forEach { adjustments in
            adjustments.constraint.update(inset: adjustments.defaultInset + keyboardHeight)
        }
        
        UIView.animate(withDuration: duration) {
            containerView.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide(_ note: Notification) {
        guard
            let containerView = containerView,
            let info = note.userInfo,
            let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double)
        else { return }
        
        adjustments.forEach { adjustments in
            adjustments.constraint.update(inset: adjustments.defaultInset)
        }
        
        UIView.animate(withDuration: duration) {
            containerView.layoutIfNeeded()
        }
    }
}
