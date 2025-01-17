//
//  RoomMoodCell.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class RoomMoodCell: BaseCollectionViewCell {
    
    // MARK: - UIComponent
    
    private let roomMoodLabel = UILabel()
    
    private let firstMoodTag = MoodTagView(roomMood: "차분한")
    private let secondMoodTag = MoodTagView(roomMood: "조용한")
    private let thirdMoodTag = MoodTagView(roomMood: "재미있는")
    private let fourthMoodTag = MoodTagView(roomMood: "Chill한")
    
    private let separatorView = UIView()
    
    private let groundRuleTitleLabel = UILabel()
    private let groundRuleStackView = UIStackView()
    
    private let groundRuleLabel1 = CheckIconLabel(text: "아침마다 뉴진스 디토를 들으며 요가를 해요, 그리고 두 줄이면 이렇게 됩니다.")
    private let groundRuleLabel2 = CheckIconLabel(text: "chill 코드는 굉장히 많지만, 신경도 안 쓰는 chill guy일 때")
    private let groundRuleLabel3 = CheckIconLabel(text: "chill 코드는 굉장히 많지만, 신경도 안 쓰는 chill guy일 때")
    private let groundRuleLabel4 = CheckIconLabel(text: "chill 코드는 굉장히 많지만, 신경도 안 쓰는 chill guy일 때")
    
    // MARK: - UISetting
    
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscale1
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
        }
        
        roomMoodLabel.do {
            $0.setText("I got no time to lose 내 길었던 하루 난 보고 싶어 Ra-ta-ta-ta 울린 심장 (Ra-ta-ta-ta) I got nothing to lose 널 좋아한다고", style: .body1, color: .grayscale12)
        }
        
        separatorView.do {
            $0.backgroundColor = .grayscale4
        }
        
        groundRuleTitleLabel.do {
            $0.setText("그라운드 룰", style: .body2, color: .grayscale12)
        }
        
        groundRuleStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .fill
            $0.distribution = .fill
        }
    }
    
    override func setUI() {
        addSubviews(
            roomMoodLabel,
            firstMoodTag,
            secondMoodTag,
            thirdMoodTag,
            fourthMoodTag,
            separatorView,
            groundRuleTitleLabel,
            groundRuleStackView
        )
        
        groundRuleStackView.addArrangedSubviews(
            groundRuleLabel1,
            groundRuleLabel2,
            groundRuleLabel3,
            groundRuleLabel4
        )
    }
    
    override func setLayout() {
        roomMoodLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
        }
        
        firstMoodTag.snp.makeConstraints {
            $0.top.equalTo(roomMoodLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        secondMoodTag.snp.makeConstraints {
            $0.top.equalTo(roomMoodLabel.snp.bottom).offset(16)
            $0.leading.equalTo(firstMoodTag.snp.trailing).offset(8)
        }
        
        thirdMoodTag.snp.makeConstraints {
            $0.top.equalTo(roomMoodLabel.snp.bottom).offset(16)
            $0.leading.equalTo(secondMoodTag.snp.trailing).offset(8)
        }
        
        fourthMoodTag.snp.makeConstraints {
            $0.top.equalTo(roomMoodLabel.snp.bottom).offset(16)
            $0.leading.equalTo(thirdMoodTag.snp.trailing).offset(8)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(firstMoodTag.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        groundRuleTitleLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        groundRuleStackView.snp.makeConstraints {
            $0.top.equalTo(groundRuleTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}

// TODO: Data Bind 함수 구현할 때 .isHidden구현, 그라운드룰 개수에 따라 addArrangedSubview해주기
// dataBind 함수에서 moodTag 개수를 역순으로 빼서 .isHidden 처리 해야 함
// 그라운드룰 개수에 따라 addArrangedSubviews 해야한다
