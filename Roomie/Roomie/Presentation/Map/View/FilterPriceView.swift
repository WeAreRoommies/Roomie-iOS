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
    
    private let depositLabel = UILabel()
    private let depositCenterView = UIView()
    let depositMinTextField = PriceTextField(placeHolder: "0")
    let depositMaxTextField = PriceTextField(placeHolder: "500")
    let depositSlider = PriceSlider()
    
    private let monthlyRentLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        depositLabel.do {
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
    }
    
    override func setUI() {
        addSubviews(
            depositLabel,
            depositCenterView,
            depositMinTextField,
            depositMaxTextField,
            depositSlider
        )
    }
    
    override func setLayout() {
        depositLabel.snp.makeConstraints {
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
            $0.top.equalTo(depositLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(depositCenterView.snp.leading).offset(-4)
            $0.height.equalTo(44)
        }
        
        depositMaxTextField.snp.makeConstraints {
            $0.top.equalTo(depositLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalTo(depositCenterView.snp.trailing).offset(4)
            $0.height.equalTo(44)
        }
        
        depositSlider.snp.makeConstraints {
            $0.top.equalTo(depositMaxTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
    }
}
