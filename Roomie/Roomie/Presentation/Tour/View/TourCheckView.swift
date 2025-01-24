//
//  TourCheckView.swift
//  Roomie
//
//  Created by 김승원 on 1/11/25.
//

import UIKit

import SnapKit
import Then

final class TourCheckView: BaseView {
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    
    private let houseTitleLabel = UILabel()
    let houseNameLabel = UILabel()
    
    private let roomTitleLabel = UILabel()
    let roomNameLabel = CheckIconLabel(text: "")
    
    let nextButton = RoomieButton(title: "이 방이 맞아요")
        
    // MARK: - UISetting
    
    override func setStyle() {
        titleLabel.do {
            $0.setText("선택하신 방이 맞는지\n확인해주세요", style: .heading2, color: .grayscale12)
        }
        
        houseTitleLabel.do {
            $0.setText("신청지점", style: .body2, color: .grayscale7)
        }
        
        houseNameLabel.do {
            $0.setText(style: .body1, color: .grayscale12)
        }
        
        roomTitleLabel.do {
            $0.setText("대상", style: .body2, color: .grayscale7)
        }
    }
    
    override func setUI() {
        addSubviews(
            titleLabel,
            houseTitleLabel,
            houseNameLabel,
            roomTitleLabel,
            roomNameLabel,
            nextButton
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        houseTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(52)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(52)
        }
        
        houseNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(52)
            $0.leading.equalTo(houseTitleLabel.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        roomTitleLabel.snp.makeConstraints {
            $0.top.equalTo(houseTitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(52)
        }
        
        roomNameLabel.snp.makeConstraints {
            $0.top.equalTo(houseNameLabel.snp.bottom).offset(16)
            $0.leading.equalTo(roomTitleLabel.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(RoomieButton.defaultHeight)
        }
    }
}
