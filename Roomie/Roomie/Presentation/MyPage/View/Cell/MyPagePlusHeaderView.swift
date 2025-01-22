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

    private let profileImageView = UIImageView()
    
    private let nicknameLabel = UILabel()
    private let nicknameDefaultLabel = UILabel()
    
    private let loginTypeView = UIView()
    private let loginTypeLabel = UILabel()
    
    private let nextImageView = UIImageView()
    
    private let dividerView = UIView()
    
    private let titleLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        profileImageView.do {
            $0.image = .imgProfile
            $0.layer.cornerRadius = 60 / 2
            $0.clipsToBounds = true
        }
        
        nicknameLabel.do {
            $0.setText(style: .title2, color: .primaryPurple)
        }
        
        nicknameDefaultLabel.do {
            $0.setText("님 안녕하세요!", style: .title2, color: .grayscale12)
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
            profileImageView,
            nicknameLabel,
            nicknameDefaultLabel,
            loginTypeView,
            nextImageView,
            dividerView,
            titleLabel
        )
        loginTypeView.addSubview(loginTypeLabel)
    }
    
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(60)
        }
        
        nextImageView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(44)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView.snp.centerY).offset(-4)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
        
        nicknameDefaultLabel.snp.makeConstraints {
            $0.centerY.equalTo(nicknameLabel.snp.centerY)
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(2)
        }
        
        loginTypeView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.centerY).offset(4)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
        
        loginTypeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(24)
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
    
    func dataBind(nickname: String) {
        nicknameLabel.updateText(nickname)
    }
}
