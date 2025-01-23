//
//  CheckIconLabel.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class CheckIconLabel: UIView {
    
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

private extension CheckIconLabel {
    func setGroundRulelabel(with text: String = "") {
        ruleLabel.setText(text, style: .body1, color: .grayscale12)
    }
}

extension CheckIconLabel {
    func updateText(_ text: String) {
        ruleLabel.updateText(text)
    }
}
