//
//  MyPageCollectionViewCell.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class MyPageCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UIComponent

    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nextImageView = UIImageView()
    
    // MARK: - UISetting

    override func setStyle() {
        titleStackView.do {
            $0.axis = .vertical
            $0.alignment = .top
            $0.distribution = .fill
            $0.spacing = 4
        }
        
        titleLabel.do {
            $0.setText(style: .body2, color: .grayscale12)
        }
        
        subtitleLabel.do {
            $0.setText(style: .body4, color: .grayscale7)
        }
        
        nextImageView.do {
            $0.image = .icnIn.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .grayscale7
        }
    }
    
    override func setUI() {
        addSubviews(titleStackView, nextImageView)
        titleStackView.addArrangedSubviews(titleLabel, subtitleLabel)
    }
    
    override func setLayout() {
        titleStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        nextImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(44)
        }
    }
}

extension MyPageCollectionViewCell {
    func dataBind(_ data: MyPageModel) {
        titleLabel.updateText(data.title)
        if data.subtitle != nil {
            subtitleLabel.updateText(data.subtitle)
        } else {
            subtitleLabel.isHidden = true
        }
    }
}
