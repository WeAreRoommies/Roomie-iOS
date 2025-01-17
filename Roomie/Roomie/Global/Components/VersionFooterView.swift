//
//  VersionFooterView.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class VersionFooterView: BaseCollectionReusableView {
    
    // MARK: - UIComponents
    
    private let barView = UIView()
    
    private let rightPolicyLabel = UILabel()
    
    private let versionLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscale1
        }
        
        barView.do {
            $0.backgroundColor = .grayscale5
        }
        
        rightPolicyLabel.do {
            $0.setText("Roomie. All Rights Reserved", style: .caption1, color: .grayscale6)
        }
        
        versionLabel.do {
            $0.setText("Version 1.0.0", style: .caption1, color: .grayscale6)
        }
    }
    
    override func setUI() {
        addSubviews(
            barView,
            rightPolicyLabel,
            versionLabel
        )
    }
    
    override func setLayout() {
        barView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
        
        rightPolicyLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(35)
            $0.centerX.equalToSuperview()
        }
        
        versionLabel.snp.makeConstraints{
            $0.top.equalTo(rightPolicyLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
    }
}
