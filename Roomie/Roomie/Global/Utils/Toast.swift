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
    func show(message: String, view: UIView) {
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
            $0.bottom.equalToSuperview().inset(10)
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
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 1, delay: 1.8, options: .curveEaseOut, animations: {
                self.alpha = 0.0
            }, completion: { _ in
                self.removeFromSuperview()
            })
        })
    }
}
