//
//  OnBoardingStepView.swift
//  Roomie
//
//  Created by MaengKim on 5/20/25.
//

import UIKit

import SnapKit
import Then

final class OnBoardingStepView: BaseView {
    
    var type: OnBoardingType?
    
    // MARK: - UIComponents
    
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    var onBoardingImageView = UIImageView()
    
    // MARK: - UISetting
    
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscale1
        }
        
        titleLabel.do {
            $0.setText(style: .onb_title1, color: .primaryPurple)
        }
        
        subtitleLabel.do {
            $0.setText(style: .onb_body1, color: .grayscale8)
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
    }
    
    override func setUI() {
        addSubviews(
            titleLabel,
            subtitleLabel,
            onBoardingImageView
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(126)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        onBoardingImageView.snp.makeConstraints{
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Screen.width(240))
        }
    }
}

// MARK: - Function

extension OnBoardingStepView {
    func configure(with type: OnBoardingType) {
        self.type = type
        titleLabel.text = type.title
        subtitleLabel.text = type.subTitle
        onBoardingImageView.image = type.onBoardingViewImage
    }
}
