//
//  FilterPeriodView.swift
//  Roomie
//
//  Created by 예삐 on 1/11/25.
//


import UIKit

import SnapKit
import Then

final class FilterPeriodView: BaseView {
    
    // MARK: - Property

    private let preferredDateLabel = UILabel()
    let preferredDatePickerView = DatePickerView()
    
    private let contractPeriodLabel = UILabel()
    let threeMonthButton = FilterOptionButton(title: "3개월")
    let sixMonthButton = FilterOptionButton(title: "6개월")
    let oneYearButton = FilterOptionButton(title: "1년")
    
    // MARK: - UISetting

    override func setStyle() {
        preferredDateLabel.do {
            $0.setText("희망 입주 날짜", style: .body2, color: .grayscale12)
        }
        
        contractPeriodLabel.do {
            $0.setText("희망 계약기간", style: .body2, color: .grayscale12)
        }
    }
    
    override func setUI() {
        addSubviews(
            preferredDateLabel,
            preferredDatePickerView,
            contractPeriodLabel,
            threeMonthButton,
            sixMonthButton,
            oneYearButton
        )
    }
    
    override func setLayout() {
        preferredDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        
        preferredDatePickerView.snp.makeConstraints {
            $0.top.equalTo(preferredDateLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
        
        contractPeriodLabel.snp.makeConstraints {
            $0.top.equalTo(preferredDatePickerView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        threeMonthButton.snp.makeConstraints {
            $0.top.equalTo(contractPeriodLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        sixMonthButton.snp.makeConstraints {
            $0.top.equalTo(contractPeriodLabel.snp.bottom).offset(12)
            $0.leading.equalTo(threeMonthButton.snp.trailing).offset(8)
        }
        
        oneYearButton.snp.makeConstraints {
            $0.top.equalTo(contractPeriodLabel.snp.bottom).offset(12)
            $0.leading.equalTo(sixMonthButton.snp.trailing).offset(8)
        }
    }
}
