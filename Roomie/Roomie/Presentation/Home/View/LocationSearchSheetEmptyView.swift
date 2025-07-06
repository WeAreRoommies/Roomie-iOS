//
//  LocationSearchSheetEmptyView.swift
//  Roomie
//
//  Created by MaengKim on 5/26/25.
//

import UIKit

import SnapKit
import Then

final class LocationSearchSheetEmptyView: BaseView {
    
    // MARK: - UIComponent
    
    private let emptyHomeImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        emptyHomeImageView.do {
            $0.image = .imgSearchPlace
        }
        
        titleLabel.do {
            $0.setText("관심 지역을 찾아봐요", style: .heading5, color: .grayscale12)
        }
        
        subTitleLabel.do {
            $0.setText("관심 지역에 위치한 셰어하우스를 확인할 수 있어요", style: .body1, color: .grayscale7)
        }
    }
    
    override func setUI() {
        addSubviews(emptyHomeImageView, titleLabel, subTitleLabel)
    }
    
    override func setLayout() {
        emptyHomeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(132)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Screen.height(180))
            $0.width.equalTo(Screen.width(180))
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(emptyHomeImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
