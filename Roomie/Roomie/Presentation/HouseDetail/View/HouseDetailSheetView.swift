//
//  HouseDetailSheetView.swift
//  Roomie
//
//  Created by 김승원 on 1/21/25.
//

import UIKit

import SnapKit
import Then

final class HouseDetailSheetView: BaseView {
    
    // MARK: - Property
    
    private(set) var buttons: [RoomTourButton] = []
    
    // MARK: - UIComponent
    
    private let grabberView = UIView()
    private let titleLabel = UILabel()
    private let separatorView = UIView()
    
    private let evenStackView = UIStackView()
    private let oddStackView = UIStackView()
    
    let tourApplyButton = RoomieButton(title: "투어신청하기", isEnabled: false)
    
    // MARK: - UISetting
    
    override func setStyle() {
        
        grabberView.do {
            $0.backgroundColor = .grayscale5
            $0.layer.cornerRadius = Screen.height(2)
            $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.setText("방 선택하기", style: .title2, color: .grayscale12)
        }
        
        separatorView.do {
            $0.backgroundColor = .grayscale4
        }
        
        evenStackView.do {
            $0.axis = .vertical
            $0.spacing = 11
            $0.alignment = .fill
            $0.distribution = .equalSpacing
        }
        
        oddStackView.do {
            $0.axis = .vertical
            $0.spacing = 11
            $0.alignment = .fill
            $0.distribution = .equalSpacing
        }
    }
    
    override func setUI() {
        addSubviews(
            grabberView,
            titleLabel,
            separatorView,
            evenStackView,
            oddStackView,
            tourApplyButton
        )
    }
    
    override func setLayout() {
        grabberView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.width.equalTo(Screen.width(37))
            $0.height.equalTo(Screen.height(4))
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(grabberView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(11)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        evenStackView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(Screen.width(162))
        }
        
        oddStackView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(Screen.width(162))
        }
        
        tourApplyButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Screen.width(RoomieButton.defaultHeight))
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(12)
        }
    }
}

extension HouseDetailSheetView {
    func dataBind(_ data: [RoomButtonInfo]) {
        for index in 0..<data.count {
            let roomTourButton = RoomTourButton(
                name: data[index].name,
                deposit: data[index].subTitle,
                isTourAvailable: data[index].isTourAvailable
            )
            
            roomTourButton.tag = index
            
            buttons.append(roomTourButton)
            
            roomTourButton.snp.makeConstraints {
                $0.height.equalTo(Screen.height(60))
            }
            
            if index % 2 == 0 {
                evenStackView.addArrangedSubview(roomTourButton)
            } else {
                oddStackView.addArrangedSubview(roomTourButton)
            }
        }
    }
}
