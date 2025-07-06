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
    
    private let backgroundImageView = UIImageView()
    private let textLogoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let loginImageView = UIImageView()
    var kakaoLoginButton = UIButton()
    var appleLoginButton = UIButton()
    
    // MARK: - UISetting
    
    override func setStyle() {
        backgroundImageView.do {
            $0.image = .imgOnboardingBg
            
        }
        
        textLogoImageView.do {
            $0.image = .imgLogoBgwhite
        }
        
        titleLabel.do {
            $0.setText("한 집에서 시작하는 새로운 연결고리, 루미", style: .title2, color: .grayscale1)
        }
        
        loginImageView.do {
            $0.image = .imgOnboardingLogin
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
            backgroundImageView,
            textLogoImageView,
            titleLabel,
            loginImageView,
            kakaoLoginButton,
            appleLoginButton
        )
    }
    
    override func setLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        textLogoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(90)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Screen.width(240))
            $0.height.equalTo(Screen.height(60))
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(textLogoImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        loginImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Screen.width(375))
            $0.height.equalTo(Screen.height(395))
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(loginImageView.snp.bottom).offset(1)
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
