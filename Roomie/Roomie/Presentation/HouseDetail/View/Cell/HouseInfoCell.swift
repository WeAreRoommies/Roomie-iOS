//
//  HouseInfoCell.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import UIKit

import SnapKit
import Then

// TODO: dataBind() 함수 구현 후 각 text 삭제
final class HouseInfoCell: BaseCollectionViewCell {
    
    // MARK: - UIComponent
    
    private let nameBackView = UIView()
    private let nameLabel = UILabel()
    
    private let titleLabel = UILabel()
    
    private let locationIconLabel = HouseInfoIconLabel("서대문구 연희동", houseInfoType: .location)
    private let occupancyTypesIconLabel = HouseInfoIconLabel("1, 2인실", houseInfoType: .occupancyTypes)
    private let occupancyStatusIconLabel = HouseInfoIconLabel("2/4인", houseInfoType: .occupancyStatus)
    private let genderPolicyIconLabel = HouseInfoIconLabel("여성전용", houseInfoType: .genderPolicy)
    private let contractTermIconLabel = HouseInfoIconLabel("3개월 이상 계약", houseInfoType: .contractTerm)
    private let firstIconLabelStackView = UIStackView()
    private let secondIconLabelStackView = UIStackView()
    
    private let lookInsidePhotoButton = LookInsidePhotoButton()
    
    private let separatorView = UIView()
    
    // MARK: - UISetting
    
    override func setStyle() {
        nameBackView.do {
            $0.backgroundColor = .primaryLight5
            $0.layer.cornerRadius = 4
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.primaryLight2.cgColor
            $0.clipsToBounds = true
        }
        
        nameLabel.do {
            $0.setText("해피쉐어 12호점", style: .body6, color: .primaryPurple)
        }
        
        titleLabel.do {
            $0.setText("월세 43~50/보증금 90~100", style: .heading2, color: .grayscale12)
        }
        
        firstIconLabelStackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        secondIconLabelStackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        separatorView.do {
            $0.backgroundColor = .grayscale3
        }
    }
    
    override func setUI() {
        super.setUI()
        addSubviews(
            nameBackView,
            titleLabel,
            firstIconLabelStackView,
            secondIconLabelStackView,
            contractTermIconLabel,
            lookInsidePhotoButton, //
            separatorView
        )
        
        nameBackView.addSubview(nameLabel)
        
        firstIconLabelStackView.addArrangedSubviews(
            locationIconLabel,
            occupancyTypesIconLabel
        )
        
        secondIconLabelStackView.addArrangedSubviews(
            occupancyStatusIconLabel,
            genderPolicyIconLabel
        )
        
//        contentView.addSubview(lookInsidePhotoButton)
    }
    
    override func setLayout() {
        nameBackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        nameLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameBackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        
        firstIconLabelStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        secondIconLabelStackView.snp.makeConstraints {
            $0.top.equalTo(firstIconLabelStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        contractTermIconLabel.snp.makeConstraints {
            $0.top.equalTo(secondIconLabelStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        lookInsidePhotoButton.snp.makeConstraints {
            $0.top.equalTo(contractTermIconLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(LookInsidePhotoButton.defaultHeight)
        }
        
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Screen.height(8))
        }
    }
}
