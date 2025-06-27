//
//  PhoneNumberEditView.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import UIKit

import SnapKit
import Then

final class PhoneNumberEditView: BaseView {
    
    // MARK: - Property

    private(set) var editButtonBottomConstraint: Constraint?
    let defaultButtonBottomInset: CGFloat = 20
    
    // MARK: - UIComponent

    let phoneNumberTextField = RoomieTextField("연락처")
    
    let inValidErrorStackView = UIStackView()
    private let inValidErrorIcon = UIImageView()
    private let inValidErrorLabel = UILabel()
    
    let editButton = MyAccountWhiteButton(title: "수정하기")
    
    // MARK: - UISetting

    override func setStyle() {
        phoneNumberTextField.do {
            $0.keyboardType = .numberPad
        }
        
        inValidErrorIcon.do {
            $0.image = .icnWarning14
            $0.contentMode = .scaleAspectFit
        }
        
        inValidErrorLabel.do {
            $0.setText("올바른 연락처를 입력해주세요", style: .body4, color: .actionError)
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
        addSubviews(phoneNumberTextField, inValidErrorStackView, editButton)
        inValidErrorStackView.addArrangedSubviews(inValidErrorIcon, inValidErrorLabel)
    }
    
    override func setLayout() {
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(RoomieTextField.defaultHeight)
        }
        
        inValidErrorStackView.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        editButton.snp.makeConstraints {
            editButtonBottomConstraint = $0.bottom
                .equalTo(safeAreaLayoutGuide.snp.bottom)
                .inset(defaultButtonBottomInset).constraint
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(MyAccountWhiteButton.defaultHeight)
        }
    }
}
