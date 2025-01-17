//
//  FilterPriceView.swift
//  Roomie
//
//  Created by 예삐 on 1/11/25.
//

import UIKit

import SnapKit
import Then

final class FilterPriceView: BaseView {
    
    // MARK: - UIComponent
    
    private let depositTitleLabel = UILabel()
    private let depositCenterView = UIView()
    let depositMinTextField = PriceTextField(placeHolder: "0")
    let depositMaxTextField = PriceTextField(placeHolder: "500")
    
    private let monthlyRentTitleLabel = UILabel()
    private let monthlyRentCenterView = UIView()
    let monthlyRentMinTextField = PriceTextField(placeHolder: "0")
    let monthlyRentMaxTextField = PriceTextField(placeHolder: "150")
    
    // MARK: - UISetting
    
    override func setStyle() {
        depositTitleLabel.do {
            $0.setText("보증금", style: .body2, color: .grayscale12)
        }
        
        depositCenterView.do {
            $0.backgroundColor = .grayscale5
        }
        
        monthlyRentTitleLabel.do {
            $0.setText("월세", style: .body2, color: .grayscale12)
        }
        
        monthlyRentCenterView.do {
            $0.backgroundColor = .grayscale5
        }
    }
    
    override func setUI() {
        addSubviews(
            depositTitleLabel,
            depositCenterView,
            depositMinTextField,
            depositMaxTextField,
            monthlyRentTitleLabel,
            monthlyRentCenterView,
            monthlyRentMinTextField,
            monthlyRentMaxTextField
        )
    }
    
    override func setLayout() {
        depositTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        
        depositCenterView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(depositMaxTextField.snp.centerY)
            $0.width.equalTo(4)
            $0.height.equalTo(2)
        }
        
        depositMinTextField.snp.makeConstraints {
            $0.top.equalTo(depositTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(depositCenterView.snp.leading).offset(-4)
            $0.height.equalTo(44)
        }
        
        depositMaxTextField.snp.makeConstraints {
            $0.top.equalTo(depositTitleLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalTo(depositCenterView.snp.trailing).offset(4)
            $0.height.equalTo(44)
        }
        
        monthlyRentTitleLabel.snp.makeConstraints {
            $0.top.equalTo(depositMinTextField.snp.bottom).offset(44)
            $0.leading.equalToSuperview().inset(20)
        }
        
        monthlyRentCenterView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(monthlyRentMaxTextField.snp.centerY)
            $0.width.equalTo(4)
            $0.height.equalTo(2)
        }
        
        monthlyRentMinTextField.snp.makeConstraints {
            $0.top.equalTo(monthlyRentTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(monthlyRentCenterView.snp.leading).offset(-4)
            $0.height.equalTo(44)
        }
        
        monthlyRentMaxTextField.snp.makeConstraints {
            $0.top.equalTo(monthlyRentTitleLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalTo(monthlyRentCenterView.snp.trailing).offset(4)
            $0.height.equalTo(44)
        }
    }
}
