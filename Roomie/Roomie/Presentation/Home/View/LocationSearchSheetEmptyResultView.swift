//
//  LocationSearchSheetEmptyResultView.swift
//  Roomie
//
//  Created by MaengKim on 7/3/25.
//

import UIKit

import SnapKit
import Then

final class LocationSearchSheetEmptyResultView: BaseView {
    
    // MARK: - UIComponent
    
    private let emptyResultImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        emptyResultImageView.do {
            $0.image = .imgSweatGomi
        }
        
        titleLabel.do {
            $0.setText("찾으시는 장소가 존재하지 않아요", style: .heading5, color: .grayscale12)
        }
        
        subTitleLabel.do {
            $0.setText("장소명을 다시 한번 확인해주세요", style: .body1, color: .grayscale7)
        }
    }
    
    override func setUI() {
        addSubviews(emptyResultImageView, titleLabel, subTitleLabel)
    }
    
    override func setLayout() {
        emptyResultImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(132)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Screen.height(160))
            $0.width.equalTo(Screen.width(160))
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(emptyResultImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
