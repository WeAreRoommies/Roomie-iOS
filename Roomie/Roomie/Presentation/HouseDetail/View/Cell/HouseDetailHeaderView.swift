//
//  HouseDetailHeaderView.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class HouseDetailHeaderView: BaseCollectionReusableView {
    
    // MARK: - UIComponent

    private let titleLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        titleLabel.do {
            $0.setText("제목입니다", style: .heading5, color: .grayscale12)
        }
    }
    
    override func setUI() {
        addSubviews(titleLabel)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}
