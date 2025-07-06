//
//  BirthDateEditView.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import UIKit

import SnapKit
import Then

final class BirthDateEditView: BaseView {
    
    // MARK: - UIComponent

    let birthDatePickerView = DatePickerView(canSelectPassedDate: true)
    
    let editButton = MyAccountWhiteButton(title: "수정하기")
    
    // MARK: - UISetting

    override func setUI() {
        addSubviews(birthDatePickerView, editButton)
    }
    
    override func setLayout() {
        birthDatePickerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(DatePickerView.defaultHeight)
        }
        
        editButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(MyAccountWhiteButton.defaultHeight)
        }
    }
}
