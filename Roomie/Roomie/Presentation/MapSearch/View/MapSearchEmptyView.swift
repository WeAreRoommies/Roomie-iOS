//
//  MapSearchEmptyView.swift
//  Roomie
//
//  Created by 예삐 on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class MapSearchEmptyView: BaseView {
    
    // MARK: - UIComponent

    private let characterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    // MARK: - UISetting

    override func setStyle() {
        characterImageView.do {
            $0.image = .imgEmptyview
        }
        
        titleLabel.do {
            $0.setText("검색결과가 없어요", style: .title2, color: .grayscale12)
        }
        
        subTitleLabel.do {
            $0.setText("정확하게 입력했는지 다시 확인해주세요", style: .body4, color: .grayscale7)
        }
    }
    
    override func setUI() {
        addSubviews(characterImageView, titleLabel, subTitleLabel)
    }
    
    override func setLayout() {
        characterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(158)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}
