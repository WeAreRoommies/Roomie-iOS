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
    private let socialTypeView = MyAccountTypeView()
    private let nameCellButton = MyAccountCellButton(title: "이름")
    private let nicknameCellButton = MyAccountCellButton(title: "닉네임")
    private let birthCellButton = MyAccountCellButton(title: "생년월일")
    private let contactCellButton = MyAccountCellButton(title: "연락처")
    private let genderCellButton = MyAccountCellButton(title: "성별")
    
    private let logoutButton = UIButton()
    private let signoutButton = UIButton()
    
    // MARK: - UISetting
    
    override func setStyle() {
        myAccountStackView.do {
            $0.axis = .vertical
            $0.spacing = 0
        }
    }
    
    override func setUI() {
        addSubviews(
            myAccountStackView,
            logoutButton,
            signoutButton
        )
        myAccountStackView.addArrangedSubviews(
            nameCellButton,
            nicknameCellButton,
            birthCellButton,
            contactCellButton,
            genderCellButton
        )
    }
    
    override func setLayout() {
        myAccountStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
