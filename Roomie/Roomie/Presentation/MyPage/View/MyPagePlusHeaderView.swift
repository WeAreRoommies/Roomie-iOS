//
//  MyPagePlusHeaderView.swift
//  Roomie
//
//  Created by 예삐 on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class MyPagePlusHeaderView: BaseCollectionReusableView {
    
    // MARK: - UIComponent

    private let profileView = UIView()
    
    private let userInfoStackView = UIStackView()
    private let nicknameLabel = UILabel()
    private let loginTypeView = UIView()
    private let loginTypeLabel = UILabel()
    
    private let nextImageView = UIImageView()
    
    private let dividerView = UIView()
    
    private let titleLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        profileView.do {
            $0.backgroundColor = .grayscale4
            $0.layer.cornerRadius = 60 / 2
        }
        
        userInfoStackView.do {
            $0.axis = .vertical
            $0.alignment = .top
            $0.distribution = .fill
            $0.spacing = 8
        }
        
        nicknameLabel.do {
            $0.setText("이루미 님 안녕하세요!", style: .title2, color: .grayscale12)
            $0.setHighlightText("이루미", style: .title2, color: .primaryPurple)
        }
        
        loginTypeView.do {
            $0.backgroundColor = .grayscale1
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.cornerRadius = 10
        }
        
        loginTypeLabel.do {
            $0.setText("카카오 계정 회원", style: .caption1, color: .grayscale9)
        }
        
        nextImageView.do {
            $0.image = .icnIn
        }
        
        dividerView.do {
            $0.backgroundColor = .grayscale3
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.grayscale4.cgColor
        }
        
        titleLabel.do {
            $0.setText(style: .body1, color: .grayscale7)
        }
    }
    
    override func setUI() {
        addSubviews(
            profileView,
            userInfoStackView,
            nextImageView,
            dividerView,
            titleLabel
        )
        userInfoStackView.addArrangedSubviews(nicknameLabel, loginTypeView)
        loginTypeView.addSubview(loginTypeLabel)
    }
    
    override func setLayout() {
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(60)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.centerY.equalTo(profileView.snp.centerY)
            $0.leading.equalTo(profileView.snp.trailing).offset(12)
        }
        
        nextImageView.snp.makeConstraints {
            $0.centerY.equalTo(profileView.snp.centerY)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(44)
        }
        
        loginTypeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
    }
}

extension MyPagePlusHeaderView {
    func configureHeader(title: String) {
        titleLabel.updateText(title)
    }
}
