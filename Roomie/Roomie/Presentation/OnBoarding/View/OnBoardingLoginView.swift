//
//  OnBoardingLoginView.swift
//  Roomie
//
//  Created by MaengKim on 5/21/25.
//

import UIKit

import SnapKit
import Then

final class OnBoardingLoginView: BaseView {
    
    // MARK: - UIComponents
    
    private let textLogoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let onBoardingLoginImageView = UIImageView()
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
        
        onBoardingLoginImageView.do {
            $0.image = .imgGomiExcited
        }
        
        kakaoLoginButton = setButton(
            title: "카카오로 계속하기",
            image: .icnKakaoLogo,
            backgroundColor: .kakaoBackground,
            textColor: .black
        )
        
        appleLoginButton = setButton(
            title: "Apple로 계속하기",
            image: .icnAppleLogo,
            backgroundColor: .black,
            textColor: .white
        )
    }
    
    override func setUI() {
        addSubviews(
            textLogoImageView,
            titleLabel,
            onBoardingLoginImageView,
            kakaoLoginButton,
            appleLoginButton
        )
    }
    
    override func setLayout() {
        textLogoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(textLogoImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        onBoardingLoginImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(240)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(onBoardingLoginImageView.snp.bottom).offset(20)
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

// MARK: - Functions

private extension OnBoardingLoginView {
    func setButton(title: String, image: UIImage, backgroundColor: UIColor, textColor: UIColor) -> UIButton {
        let button = UIButton(configuration: .plain())
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8.6
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isUserInteractionEnabled = false
        
        let icon = UIImageView(image: image)
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        let label = UILabel()
        label.setText("\(title)", style: .title2, color: textColor)
        label.textAlignment = .center
        
        stackView.addArrangedSubviews(icon, label)
        button.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(14)
            $0.verticalEdges.equalToSuperview().inset(11)
        }
        return button
    }
}
