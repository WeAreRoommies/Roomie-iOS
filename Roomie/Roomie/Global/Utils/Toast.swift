//
//  Toast.swift
//  Roomie
//
//  Created by 예삐 on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class Toast: UIView {
    func show(message: String, inset: CGFloat, view: UIView) {
        let toastLabel = UILabel().then {
            $0.setText(message, style: .body2, color: .grayscale1)
            $0.textAlignment = .center
            $0.clipsToBounds = true
            $0.sizeToFit()
        }
        
        layer.cornerRadius = 8
        backgroundColor = .transpGray1180
        isUserInteractionEnabled = false
        
        view.addSubview(self)
        addSubview(toastLabel)
        
        self.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(inset)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(48)
        }
        
        toastLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        animateToast()
    }
}

private extension Toast {
    func animateToast() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn) {
            self.alpha = 1.0
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0.6, options: .curveEaseOut) {
                self.alpha = 0.0
            } completion: { _ in
                self.removeFromSuperview()
            }
        }
    }
}

extension Toast {
    /// 화면의 최상단에 Toast 메시지를 표시합니다.
    /// bottomInset 기본 값 Screen.height(100)은 하단 TabBar 위에 위치하도록 합니다.
    static func show(message: String, bottomInset: CGFloat = Screen.height(100)) {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first(where: { $0.isKeyWindow }) else {
            return
        }
        
        let toast = Toast()
        toast.alpha = 0.0
        toast.show(message: message, inset: bottomInset, view: window)
    }
}
