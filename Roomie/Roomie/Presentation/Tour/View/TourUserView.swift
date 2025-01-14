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
    let nameTextField = TourTextField()
    
    private let birthLabel = UILabel()
    let birthPickerView = DatePickerView()
    
    private let genderLabel = UILabel()
    let maleButton = GenderButton(gender: .male)
    let femaleButton = GenderButton(gender: .female)
    private let genderButtonStackView = UIStackView()
    
    private let phoneNumberLabel = UILabel()
    let phoneNumberTextField = TourTextField(placeHolder: "", isErrorExist: true)
    
    private let inValidErrorIcon = UIImageView()
    private let inValidErrorLabel = UILabel()
    let inValidErrorStackView = UIStackView()
    
    let nextButton = RoomieButton(title: "다음으로", isEnabled: false)
    
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
        
        genderLabel.do {
            $0.setText("성별", style: .body2, color: .grayscale10)
        }
        
        genderButtonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 11
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        phoneNumberLabel.do {
            $0.setText("연락처", style: .body2, color: .grayscale10)
        }
        
        phoneNumberTextField.do {
            $0.keyboardType = .numberPad
        }
        
        inValidErrorIcon.do {
            $0.image = .icnWarning14
            $0.contentMode = .scaleAspectFit
        }
        
        inValidErrorLabel.do {
            $0.setText("휴대폰 번호 형식이 잘못되었어요", style: .body4, color: .actionError)
        }
        
        inValidErrorStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .fill
            $0.distribution = .fill
            $0.isHidden = true
        }
    }
    
    override func setUI() {
        addSubviews(
            titleLabel,
            subTitleLabel,
            nameLabel,
            nameTextField,
            birthLabel,
            birthPickerView,
            genderLabel,
            genderButtonStackView,
            phoneNumberLabel,
            phoneNumberTextField,
            nextButton,
            inValidErrorStackView
        )
        
        genderButtonStackView.addArrangedSubviews(
            maleButton,
            femaleButton
        )
        
        inValidErrorStackView.addArrangedSubviews(
            inValidErrorIcon,
            inValidErrorLabel
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
            $0.height.equalTo(TourTextField.defaultHeight)
        }
        
        birthLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        birthPickerView.snp.makeConstraints {
            $0.top.equalTo(birthLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(DatePickerView.defaultHeight)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(birthPickerView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        genderButtonStackView.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(GenderButton.defaultHeight)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(genderButtonStackView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(TourTextField.defaultHeight)
        }
        
        inValidErrorIcon.snp.makeConstraints {
            $0.width.equalTo(Screen.width(14))
            $0.height.equalTo(Screen.height(14))
        }
        
        inValidErrorStackView.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(RoomieButton.defaultHeight)
        }
    }
}
