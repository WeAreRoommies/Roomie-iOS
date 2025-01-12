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
    let depositSlider = PriceSlider()
    private let depositMinLabel = UILabel()
    private let depositMaxLabel = UILabel()
    
    private let monthlyRentTitleLabel = UILabel()
    private let monthlyRentCenterView = UIView()
    let monthlyRentMinTextField = PriceTextField(placeHolder: "0")
    let monthlyRentMaxTextField = PriceTextField(placeHolder: "500")
    let monthlyRentSlider = PriceSlider()
    private let monthlyRentMinLabel = UILabel()
    private let monthlyRentMaxLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        depositTitleLabel.do {
            $0.setText("보증금", style: .body2, color: .grayscale12)
        }
        
        depositCenterView.do {
            $0.backgroundColor = .grayscale5
        }
        
        depositSlider.do {
            $0.minValue = 0
            $0.maxValue = 500
            $0.min = 0
            $0.max = 500
        }
        
        depositMinLabel.do {
            $0.setText("0만원", style: .body4, color: .grayscale12)
        }
        
        depositMaxLabel.do {
            $0.setText("500만원", style: .body4, color: .grayscale12)
        }
        
        monthlyRentTitleLabel.do {
            $0.setText("월세", style: .body2, color: .grayscale12)
        }
        
        monthlyRentCenterView.do {
            $0.backgroundColor = .grayscale5
        }
        
        monthlyRentSlider.do {
            $0.minValue = 0
            $0.maxValue = 150
            $0.min = 0
            $0.max = 150
        }
        
        monthlyRentMinLabel.do {
            $0.setText("0만원", style: .body4, color: .grayscale12)
        }
        
        monthlyRentMaxLabel.do {
            $0.setText("150만원", style: .body4, color: .grayscale12)
        }
    }
    
    override func setUI() {
        addSubviews(
            depositTitleLabel,
            depositCenterView,
            depositMinTextField,
            depositMaxTextField,
            depositSlider,
            depositMinLabel,
            depositMaxLabel,
            monthlyRentTitleLabel,
            monthlyRentCenterView,
            monthlyRentMinTextField,
            monthlyRentMaxTextField,
            monthlyRentSlider,
            monthlyRentMinLabel,
            monthlyRentMaxLabel
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
        
        depositSlider.snp.makeConstraints {
            $0.top.equalTo(depositMaxTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        
        depositMinLabel.snp.makeConstraints {
            $0.top.equalTo(depositSlider.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        depositMaxLabel.snp.makeConstraints {
            $0.top.equalTo(depositSlider.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        monthlyRentTitleLabel.snp.makeConstraints {
            $0.top.equalTo(depositMinLabel.snp.bottom).offset(44)
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
        
        monthlyRentSlider.snp.makeConstraints {
            $0.top.equalTo(monthlyRentMaxTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        
        monthlyRentMinLabel.snp.makeConstraints {
            $0.top.equalTo(monthlyRentSlider.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        monthlyRentMaxLabel.snp.makeConstraints {
            $0.top.equalTo(monthlyRentSlider.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
