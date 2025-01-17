//
//  GroundRuleLabel.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class GroundRuleLabel: UIView {
    
    // MARK: - UIComponent
    
    private let iconImageView = UIImageView()
    
    private let ruleLabel = UILabel()
    
    // MARK: - Initializer
    
    init(text: String) {
        super.init(frame: .zero)
        
        setGroundRulelabel(with: text)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setGroundRulelabel()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setGroundRulelabel()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        iconImageView.do {
            $0.image = .icnCheckPriamrycolor20
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setUI() {
        addSubviews(iconImageView, ruleLabel)
    }
    
    private func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(Screen.width(20))
        }
        
        ruleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview()
        }
    }
}

private extension GroundRuleLabel {
    func setGroundRulelabel(with text: String = "") {
        ruleLabel.setText(text, style: .body1, color: .grayscale12)
    }
}

// TODO: Data Bind 함수 구현할 때 .isHidden구현, 그라운드룰 개수에 따라 addArrangedSubview해주기

private extension GroundRuleLabel {
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
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn) {
            self.alpha = 1.0
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>)
    }
    
}
