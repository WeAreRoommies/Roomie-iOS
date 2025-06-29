//
//  MyAccountView.swift
//  Roomie
//
//  Created by 예삐 on 5/31/25.
//

import UIKit

import SnapKit
import Then

final class MyAccountView: BaseView {
    
    // MARK: - UIComponent

    private let myAccountStackView = UIStackView()
    let socialTypeView = MyAccountTypeView()
    let nameCellButton = MyAccountCellButton(title: "이름")
    let nicknameCellButton = MyAccountCellButton(title: "닉네임")
    let birthDateCellButton = MyAccountCellButton(title: "생년월일")
    let phoneNumberCellButton = MyAccountCellButton(title: "연락처")
    let genderCellButton = MyAccountCellButton(title: "성별")
    
    let logoutButton = MyAccountWhiteButton(title: "로그아웃", isEnabled: false)
    let signoutButton = UIButton()
    
    // MARK: - UISetting
    
    override func setStyle() {
        myAccountStackView.do {
            $0.axis = .vertical
            $0.spacing = 0
        }
        
        signoutButton.do {
            $0.setTitle("탈퇴하기", style: .body5, color: .grayscale7)
        }
    }
    
    override func setUI() {
        addSubviews(
            myAccountStackView,
            logoutButton,
            signoutButton
        )
        myAccountStackView.addArrangedSubviews(
            socialTypeView,
            nameCellButton,
            nicknameCellButton,
            birthDateCellButton,
            phoneNumberCellButton,
            genderCellButton
        )
    }
    
    override func setLayout() {
        myAccountStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints {
            $0.bottom.equalTo(signoutButton.snp.top).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20).priority(.high)
            $0.height.equalTo(Screen.height(44))
        }
        
        signoutButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Screen.height(26))
        }
    }
}
