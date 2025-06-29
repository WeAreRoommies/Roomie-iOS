//
//  GenderEditView.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import UIKit

import SnapKit
import Then

final class GenderEditView: BaseView {
    
    // MARK: - UIComponent

    let maleButton = RoomieHalfButton(gender: .male)
    let femaleButton = RoomieHalfButton(gender: .female)
    
    let editButton = MyAccountWhiteButton(title: "수정하기")
    
    // MARK: - UISetting

    override func setUI() {
        addSubviews(maleButton, femaleButton, editButton)
    }
    
    override func setLayout() {
        maleButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(24)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(RoomieHalfButton.defaultWidth)
            $0.height.equalTo(RoomieHalfButton.defaultHeight)
        }
        
        femaleButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(24)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(RoomieHalfButton.defaultWidth)
            $0.height.equalTo(RoomieHalfButton.defaultHeight)
        }
        
        editButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(MyAccountWhiteButton.defaultHeight)
        }
    }
}
