//
//  HouseDetailSheetView.swift
//  Roomie
//
//  Created by 김승원 on 1/21/25.
//

import UIKit

import SnapKit
import Then

final class HouseDetailSheetView: BaseView {
    
    // MARK: - UIComponent
    
    private let grabberView = UIView()
    private let titleLabel = UILabel()
    private let separatorView = UIView()
    
    // MARK: - UISetting
    
    override func setStyle() {
        
        grabberView.do {
            $0.backgroundColor = .grayscale5
            $0.layer.cornerRadius = Screen.height(2)
            $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.setText("방 선택하기", style: .title2, color: .grayscale12)
        }
        
        separatorView.do {
            $0.backgroundColor = .grayscale4
        }
    }
    
    override func setUI() {
        addSubviews(grabberView, titleLabel, separatorView)
    }
    
    override func setLayout() {
        grabberView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.width.equalTo(Screen.width(37))
            $0.height.equalTo(Screen.height(4))
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(grabberView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(11)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
}
