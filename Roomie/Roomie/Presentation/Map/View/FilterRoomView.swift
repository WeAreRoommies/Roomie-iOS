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
    private let maleButton = FilterOptionButton(title: "남성전용")
    private let femaleButton = FilterOptionButton(title: "여성전용")
    private let genderDivisionButton = FilterOptionButton(title: "남녀분리")
    private let genderFreeButton = FilterOptionButton(title: "성별무관")
    
    private let occupancyTypeLabl = UILabel()
    private let singleButton = FilterOptionButton(title: "1인실")
    private let doubleButton = FilterOptionButton(title: "2인실")
    private let tripleButton = FilterOptionButton(title: "3인실")
    private let quadButton = FilterOptionButton(title: "4인실")
    private let quintButton = FilterOptionButton(title: "5인실")
    private let sextButton = FilterOptionButton(title: "6인실")
    
    override func setStyle() {
        genderLabel.do {
            $0.setText("성별", style: .body2, color: .grayscale12)
        }
        
        occupancyTypeLabl.do {
            $0.setText("룸 타입", style: .body2, color: .grayscale12)
        }
    }
    
    override func setUI() {
        addSubviews(
            genderLabel,
            maleButton,
            femaleButton,
            genderDivisionButton,
            genderFreeButton,
            occupancyTypeLabl,
            singleButton,
            doubleButton,
            tripleButton,
            quadButton,
            quintButton,
            sextButton
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
        
        occupancyTypeLabl.snp.makeConstraints {
            $0.top.equalTo(maleButton.snp.bottom).offset(48)
            $0.leading.equalToSuperview().inset(20)
        }
        
        singleButton.snp.makeConstraints {
            $0.top.equalTo(occupancyTypeLabl.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        doubleButton.snp.makeConstraints {
            $0.top.equalTo(occupancyTypeLabl.snp.bottom).offset(12)
            $0.leading.equalTo(singleButton.snp.trailing).offset(8)
        }
        
        tripleButton.snp.makeConstraints {
            $0.top.equalTo(occupancyTypeLabl.snp.bottom).offset(12)
            $0.leading.equalTo(doubleButton.snp.trailing).offset(8)
        }
        
        quadButton.snp.makeConstraints {
            $0.top.equalTo(occupancyTypeLabl.snp.bottom).offset(12)
            $0.leading.equalTo(tripleButton.snp.trailing).offset(8)
        }
        
        quintButton.snp.makeConstraints {
            $0.top.equalTo(singleButton.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        
        sextButton.snp.makeConstraints {
            $0.top.equalTo(singleButton.snp.bottom).offset(8)
            $0.leading.equalTo(quintButton.snp.trailing).offset(8)
        }
    }
}
