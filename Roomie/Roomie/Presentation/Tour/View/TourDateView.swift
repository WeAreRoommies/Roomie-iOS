//
//  TourDateView.swift
//  Roomie
//
//  Created by 김승원 on 1/15/25.
//

import UIKit

import SnapKit
import Then

final class TourDateView: BaseView {
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    
    private let preferredDateLabel = UILabel()
    private let preferredDatePickerView = DatePickerView()
    
    private let messageLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        titleLabel.do {
            $0.setText("입주희망일과\n문의하고 싶은 내용을 적어주세요", style: .heading2, color: .grayscale12)
        }
        
        preferredDateLabel.do {
            $0.setText("입주 희망날짜", style: .body2, color: .grayscale10)
        }
        
        messageLabel.do {
            $0.setText("문의내용", style: .body2, color: .grayscale10)
        }
    }
    
    override func setUI() {
        addSubviews(
            titleLabel,
            preferredDateLabel,
            preferredDatePickerView,
            messageLabel
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        preferredDateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(54)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        preferredDatePickerView.snp.makeConstraints {
            $0.top.equalTo(preferredDateLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Screen.height(54))
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(preferredDatePickerView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
