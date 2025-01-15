//
//  TourCompleteView.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class TourCompleteView: BaseView {
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    // TODO: GUI 나오면 붙이기
    
    let lookOtherButton = OtherButton(title: "다른 방 보러가기")
    let completeButton = RoomieButton(title: "완료하기", isEnabled: true)
    
    // MARK: - UISetting
    
    override func setStyle() {
        titleLabel.do {
            $0.setText("투어신청이 완료되었어요!", style: .heading2, color: .grayscale12)
            $0.textAlignment = .center
        }
        
        subTitleLabel.do {
            $0.setText("신청내용은 카카오톡으로 전달드렸어요", style: .body4, color: .grayscale8)
        }
    }
    
    override func setUI() {
        addSubviews(
            titleLabel,
            subTitleLabel,
            lookOtherButton,
            completeButton
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(168)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        lookOtherButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(OtherButton.defaultHeight)
            $0.width.equalTo(OtherButton.defaultWidth)
        }
        
        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
            $0.leading.equalTo(lookOtherButton.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(OtherButton.defaultHeight)
        }
    }
}
