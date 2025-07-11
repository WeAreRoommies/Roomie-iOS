//
//  NicknameEditView.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import UIKit

import SnapKit
import Then

final class NicknameEditView: BaseView {
    
    // MARK: - Property

    private(set) var editButtonBottomConstraint: Constraint?
    let defaultButtonBottomInset: CGFloat = 20
    
    // MARK: - UIComponent

    let nicknameTextField = RoomieTextField("닉네임")
    
    let inValidErrorStackView = UIStackView()
    private let inValidErrorIcon = UIImageView()
    private let inValidErrorLabel = UILabel()
    
    let editButton = MyAccountWhiteButton(title: "수정하기")
    
    // MARK: - UISetting

    override func setStyle() {
        inValidErrorIcon.do {
            $0.image = .icnWarning14
            $0.contentMode = .scaleAspectFit
        }
        
        inValidErrorLabel.do {
            $0.setText("닉네임은 2~12자의 한글, 영문, 숫자만 입력 가능합니다", style: .body4, color: .actionError)
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
        addSubviews(nicknameTextField, inValidErrorStackView, editButton)
        inValidErrorStackView.addArrangedSubviews(inValidErrorIcon, inValidErrorLabel)
    }
    
    override func setLayout() {
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(RoomieTextField.defaultHeight)
        }
        
        inValidErrorStackView.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(4)
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
