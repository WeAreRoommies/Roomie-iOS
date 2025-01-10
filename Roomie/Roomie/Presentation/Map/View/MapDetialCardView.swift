//
//  MapDetialInfoView.swift
//  Roomie
//
//  Created by 예삐 on 1/10/25.
//

import UIKit

import SnapKit
import Then

final class MapDetialCardView: BaseView {
    
    // MARK: - UIComponent

    let titleLabel = UILabel()
    
    private let subtitleStackView = UIStackView()
    private let seperatorView = UIView()
    let depositLabel = UILabel()
    let contractTermLabel = UILabel()
    
    let genderOccupancyLabel = UILabel()
    let locationLabel = UILabel()
    
    private let moodTagView = UIView()
    let moodTagLabel = UILabel()
    
    let arrowButton = UIButton()
    
    // MARK: - UISetting

    override func setStyle() {
        titleLabel.do {
            $0.setText(style: .title2, color: .grayscale12)
        }
        
        subtitleStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        depositLabel.do {
            $0.setText(style: .body5, color: .primaryPurple)
        }
        
        contractTermLabel.do {
            $0.setText(style: .body5, color: .primaryPurple)
        }
        
        seperatorView.do {
            $0.backgroundColor = .primaryPurple
        }
        
        genderOccupancyLabel.do {
            $0.setText(style: .body4, color: .grayscale7)
        }
        
        locationLabel.do {
            $0.setText(style: .body4, color: .grayscale7)
        }
        
        moodTagView.do {
            $0.backgroundColor = .grayscale3
            $0.layer.cornerRadius = 4
        }
        
        moodTagLabel.do {
            $0.setText(style: .body4, color: .grayscale9)
        }
        
        arrowButton.do {
            $0.setImage(.icnArrowRightLine40, for: .normal)
        }
    }
    
    override func setUI() {
        addSubviews(
            titleLabel,
            subtitleStackView,
            genderOccupancyLabel,
            locationLabel,
            moodTagView,
            arrowButton
        )
        subtitleStackView.addArrangedSubviews(
            depositLabel,
            seperatorView,
            contractTermLabel
        )
        moodTagView.addSubview(moodTagLabel)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        subtitleStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
        }
        
        seperatorView.snp.makeConstraints {
            $0.width.equalTo(2)
            $0.height.equalTo(12)
        }
        
        genderOccupancyLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(genderOccupancyLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(16)
        }
        
        moodTagView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        moodTagLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        arrowButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.size.equalTo(40)
        }
    }
}
