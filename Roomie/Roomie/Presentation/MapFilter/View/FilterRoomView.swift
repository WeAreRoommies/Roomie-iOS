//
//  FilterRoomView.swift
//  Roomie
//
//  Created by 예삐 on 1/11/25.
//

import UIKit

import SnapKit
import Then

final class FilterRoomView: BaseView {
    
    private let genderLabel = UILabel()
    let maleButton = FilterOptionButton(title: "남성전용")
    let femaleButton = FilterOptionButton(title: "여성전용")
    let genderDivisionButton = FilterOptionButton(title: "남녀분리")
    let genderFreeButton = FilterOptionButton(title: "성별무관")
    
    private let occupancyTypeLabel = UILabel()
    let singleButton = FilterOptionButton(title: "1인실")
    let doubleButton = FilterOptionButton(title: "2인실")
    let tripleButton = FilterOptionButton(title: "3인실")
    let quadButton = FilterOptionButton(title: "4인실 이상")
    
    private let moodTagLabel = UILabel()
    let calmButton = FilterOptionButton(title: "차분한")
    let livelyButton = FilterOptionButton(title: "활기찬")
    let neatButton = FilterOptionButton(title: "깔끔한")
    
    override func setStyle() {
        genderLabel.do {
            $0.setText("성별", style: .body2, color: .grayscale12)
        }
        
        occupancyTypeLabel.do {
            $0.setText("룸 타입", style: .body2, color: .grayscale12)
        }
        
        moodTagLabel.do {
            $0.setText("분위기", style: .body2, color: .grayscale12)
        }
    }
    
    override func setUI() {
        addSubviews(
            genderLabel,
            maleButton,
            femaleButton,
            genderDivisionButton,
            genderFreeButton,
            occupancyTypeLabel,
            singleButton,
            doubleButton,
            tripleButton,
            quadButton,
            moodTagLabel,
            calmButton,
            livelyButton,
            neatButton
        )
    }
    
    override func setLayout() {
        genderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        
        maleButton.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        femaleButton.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(12)
            $0.leading.equalTo(maleButton.snp.trailing).offset(8)
        }
        
        genderDivisionButton.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(12)
            $0.leading.equalTo(femaleButton.snp.trailing).offset(8)
        }
        
        genderFreeButton.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(12)
            $0.leading.equalTo(genderDivisionButton.snp.trailing).offset(8)
        }
        
        occupancyTypeLabel.snp.makeConstraints {
            $0.top.equalTo(maleButton.snp.bottom).offset(48)
            $0.leading.equalToSuperview().inset(20)
        }
        
        singleButton.snp.makeConstraints {
            $0.top.equalTo(occupancyTypeLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        doubleButton.snp.makeConstraints {
            $0.top.equalTo(occupancyTypeLabel.snp.bottom).offset(12)
            $0.leading.equalTo(singleButton.snp.trailing).offset(8)
        }
        
        tripleButton.snp.makeConstraints {
            $0.top.equalTo(occupancyTypeLabel.snp.bottom).offset(12)
            $0.leading.equalTo(doubleButton.snp.trailing).offset(8)
        }
        
        quadButton.snp.makeConstraints {
            $0.top.equalTo(occupancyTypeLabel.snp.bottom).offset(12)
            $0.leading.equalTo(tripleButton.snp.trailing).offset(8)
        }
        
        moodTagLabel.snp.makeConstraints {
            $0.top.equalTo(singleButton.snp.bottom).offset(48)
            $0.leading.equalToSuperview().inset(20)
        }
        
        calmButton.snp.makeConstraints {
            $0.top.equalTo(moodTagLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        livelyButton.snp.makeConstraints {
            $0.top.equalTo(moodTagLabel.snp.bottom).offset(12)
            $0.leading.equalTo(calmButton.snp.trailing).offset(8)
        }
        
        neatButton.snp.makeConstraints {
            $0.top.equalTo(moodTagLabel.snp.bottom).offset(12)
            $0.leading.equalTo(livelyButton.snp.trailing).offset(8)
        }
    }
}
