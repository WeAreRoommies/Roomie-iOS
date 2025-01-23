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
    
    let roomATourButton = RoomTourButton(name: "A", deposit: "500/50", isTourAvailable: true)
    let roomBTourButton = RoomTourButton(name: "B", deposit: "500/50", isTourAvailable: true)
    private let firstStackView = UIStackView()
    
    let roomCTourButton = RoomTourButton(name: "C", deposit: "500/50", isTourAvailable: true)
    let roomDTourButton = RoomTourButton(name: "D", deposit: "500/50", isTourAvailable: false)
    private let secondStackView = UIStackView()
    
    let roomETourButton = RoomTourButton(name: "E", deposit: "500/50", isTourAvailable: false)
    let roomFTourButton = RoomTourButton(name: "F", deposit: "500/50", isTourAvailable: true)
    private let thirdStackView = UIStackView()
    
    let tourApplyButton = RoomieButton(title: "투어신청하기", isEnabled: false)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setButtons()
    }
    
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
        
        firstStackView.do {
            $0.axis = .horizontal
            $0.spacing = 11
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        secondStackView.do {
            $0.axis = .horizontal
            $0.spacing = 11
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        thirdStackView.do {
            $0.axis = .horizontal
            $0.spacing = 11
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
    }
    
    override func setUI() {
        addSubviews(
            grabberView,
            titleLabel,
            separatorView,
            firstStackView,
            secondStackView,
            thirdStackView,
            tourApplyButton
        )
        
        firstStackView.addArrangedSubviews(roomATourButton, roomBTourButton)
        secondStackView.addArrangedSubviews(roomCTourButton, roomDTourButton)
        thirdStackView.addArrangedSubviews(roomETourButton, roomFTourButton)
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
        
        firstStackView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Screen.height(60))
        }
        
        secondStackView.snp.makeConstraints {
            $0.top.equalTo(firstStackView.snp.bottom).offset(11)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Screen.height(60))
        }
        
        thirdStackView.snp.makeConstraints {
            $0.top.equalTo(secondStackView.snp.bottom).offset(11)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Screen.height(60))
        }
        
        tourApplyButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Screen.width(RoomieButton.defaultHeight))
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(12)
        }
    }
}

private extension HouseDetailSheetView {
    func setButtons() {
        buttons.append(roomATourButton)
        roomATourButton.tag = 0
        
        buttons.append(roomBTourButton)
        roomBTourButton.tag = 1
        
        buttons.append(roomCTourButton)
        roomCTourButton.tag = 2
        
        buttons.append(roomDTourButton)
        roomDTourButton.tag = 3
        
        buttons.append(roomETourButton)
        roomETourButton.tag = 4
        
        buttons.append(roomFTourButton)
        roomFTourButton.tag = 5
    }
}

extension HouseDetailSheetView {
    func dataBind(_ roomButtonInfos: [RoomButtonInfo]) {
        let visibleButtonCount = roomButtonInfos.count
        for index in visibleButtonCount..<6 {
            buttons[index].isHidden = true
        }
    }
}
