//
//  LoginView.swift
//  Roomie
//
//  Created by MaengKim on 5/21/25.
//

import UIKit

import SnapKit
import Then

final class LoginView: BaseView {
    
    // MARK: - UIComponents
    
    private let textLogoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let loginImageView = UIImageView()
    var kakaoLoginButton = UIButton()
    var appleLoginButton = UIButton()
    
    // MARK: - UISetting
    
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscale1
        }
        
        textLogoImageView.do {
            $0.image = .icnHeart24Active
        }
        
        titleLabel.do {
            $0.setText("한 집에서 시작하는 새로운 연결고리, 루미", style: .title2, color: .primaryPurple)
        }
        
        loginImageView.do {
            $0.image = .imgGomiExcited
        }
        
        kakaoLoginButton.do {
            $0.setImage(.imgKakaoLogin, for: .normal)
        }
        
        appleLoginButton.do {
            $0.setImage(.imgAppleLogin, for: .normal)
        }
    }
    
    override func setUI() {
        addSubviews(
            textLogoImageView,
            titleLabel,
            loginImageView,
            kakaoLoginButton,
            appleLoginButton
        )
    }
    
    override func setLayout() {
        textLogoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Screen.width(100))
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(textLogoImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        loginImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(240)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(loginImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Screen.width(320))
            $0.height.equalTo(Screen.height(45))
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.top.equalTo(kakaoLoginButton.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Screen.width(320))
            $0.height.equalTo(Screen.height(45))
        }
    }
}
