//
//  MyPageServiceHeaderView.swift
//  Roomie
//
//  Created by 예삐 on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class MyPageServiceHeaderView: BaseCollectionReusableView {
    
    // MARK: - UIComponent
    
    private let dividerView = UIView()

    private let titleLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        dividerView.do {
            $0.backgroundColor = .grayscale4
        }
        
        titleLabel.do {
            $0.setText(style: .body1, color: .grayscale7)
        }
    }
    
    override func setUI() {
        addSubviews(dividerView, titleLabel)
    }
    
    override func setLayout() {
        dividerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(20)
        }
    }
}

extension MyPageServiceHeaderView {
    func configureHeader(title: String) {
        titleLabel.updateText(title)
    }
}
