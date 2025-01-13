//
//  TourUserView.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import UIKit

import SnapKit
import Then

final class TourUserView: BaseView {
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    private let nameLabel = UILabel()
    let nameTextField = BasicTextField(placeHolder: "")
    
    private let birthLabel = UILabel()
    let birthPickerTextField = PickerTextField()
    
    // MARK: - UISetting
    
    override func setStyle() {
        titleLabel.do {
            $0.setText("호스트와 연락하기 위한\n정보를 알려주세요", style: .heading2, color: .grayscale12)
        }
        
        subTitleLabel.do {
            $0.setText("개인정보는 안전하게 지키고 있어요", style: .body4, color: .grayscale8)
        }
        
        nameLabel.do {
            $0.setText("이름", style: .body2, color: .grayscale10)
        }
        
        birthLabel.do {
            $0.setText("생년월일", style: .body2, color: .grayscale10)
        }
    }
    
    override func setUI() {
        addSubviews(
            titleLabel,
            subTitleLabel,
            nameLabel,
            nameTextField,
            birthLabel,
            birthPickerTextField
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(BasicTextField.defaultHeight)
        }
        
        birthLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        birthPickerTextField.snp.makeConstraints {
            $0.top.equalTo(birthLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(DatePickerView.defaultHeight)
        }
    }
    
}
