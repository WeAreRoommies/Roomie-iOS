//
//  RoomStatusTableViewCell.swift
//  Roomie
//
//  Created by 김승원 on 1/18/25.
//

import UIKit

import SnapKit
import Then

final class RoomStatusTableViewCell: BaseTableViewCell {
    
    // MARK: - UIComponent
    
    private let containerView = UIView()

    private let statusView = RoomStatusView()
    
    private let chevronRightIcon = UIImageView()
    
    private let nameLabel = UILabel()
    
    private let infoContentView = UIView()
    
    // 방 형태
    private let roomTypeTitleLabel = UILabel()
    private let roomTypeLabel = UILabel()
    
    // 보증금
    private let depositTitleLabel = UILabel()
    private let depositLabel = UILabel()
    
    // 관리비
    private let managementFeeTitleLabel = UILabel()
    private let managementFeeLabel = UILabel()
    
    // 월세
    private let monthlyRentTitleLabel = UILabel()
    private let monthlyRentLabel = UILabel()
    
    // 계약기간
    private let contractPeriodTitleLabel = UILabel()
    private let contractPeriodLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        containerView.do {
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.clipsToBounds = true
        }
        
        chevronRightIcon.do {
            $0.image = .icnArrowRightLine24
            $0.contentMode = .scaleAspectFit
        }
        
        nameLabel.do {
            $0.setText(style: .heading5, color: .grayscale11)
        }
        
        roomTypeTitleLabel.do {
            $0.setText("방 형태", style: .body3, color: .grayscale8)
        }
        
        roomTypeLabel.do {
            $0.setText(style: .body1, color: .grayscale11)
        }
        
        depositTitleLabel.do {
            $0.setText("보증금", style: .body3, color: .grayscale8)
        }
        
        depositLabel.do {
            $0.setText(style: .body1, color: .grayscale11)
        }
        
        contractPeriodTitleLabel.do {
            $0.setText("계약기간", style: .body3, color: .grayscale8)
        }
        
        contractPeriodLabel.do {
            $0.setText(style: .body1, color: .grayscale11)
        }
        
        monthlyRentTitleLabel.do {
            $0.setText("월세", style: .body3, color: .grayscale8)
        }
        
        monthlyRentLabel.do {
            $0.setText(style: .body1, color: .grayscale11)
        }
        
        managementFeeTitleLabel.do {
            $0.setText("관리비", style: .body3, color: .grayscale8)
        }
        
        managementFeeLabel.do {
            $0.setText(style: .body1, color: .grayscale11)
        }
    }
    
    override func setUI() {
        addSubview(containerView)
        
        containerView.addSubviews(
            statusView,
            chevronRightIcon,
            nameLabel,
            infoContentView
        )
        
        infoContentView.addSubviews(
            roomTypeTitleLabel,
            roomTypeLabel,
            depositTitleLabel,
            depositLabel,
            contractPeriodTitleLabel,
            contractPeriodLabel,
            monthlyRentTitleLabel,
            monthlyRentLabel,
            managementFeeTitleLabel,
            managementFeeLabel
        )
    }
    
    override func setLayout() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
        
        statusView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        chevronRightIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(Screen.width(24))
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(statusView.snp.bottom).offset(Screen.height(8))
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(chevronRightIcon.snp.leading).offset(19)
        }
        
        infoContentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(Screen.height(76))
        }
        
        //
        
        roomTypeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(Screen.width(60))
        }
        
        roomTypeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(roomTypeTitleLabel.snp.trailing).offset(12)
            $0.width.equalTo(Screen.width(68))
        }
        
        depositTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalTo(depositLabel.snp.leading).offset(-12)
            $0.width.equalTo(Screen.width(37))
        }
        
        depositLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(Screen.width(78))
        }
        
        contractPeriodTitleLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.width.equalTo(Screen.width(60))
        }
        
        contractPeriodLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(managementFeeTitleLabel.snp.trailing).offset(12)
            $0.width.equalTo(Screen.width(78))
        }
        
        monthlyRentTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(monthlyRentLabel.snp.leading).offset(-12)
            $0.width.equalTo(Screen.width(37))
        }
        
        monthlyRentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(Screen.width(78))
        }
        
        managementFeeTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(Screen.width(60))
        }
        
        managementFeeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(contractPeriodTitleLabel.snp.trailing).offset(12)
            $0.width.equalTo(Screen.width(68))
        }
    }
}

// MARK: - Functions

extension RoomStatusTableViewCell {
    func dataBind(_ roomInfo: RoomInfo) {
        statusView.isAvailable = roomInfo.status
        nameLabel.updateText(roomInfo.name)
        roomTypeLabel.updateText(roomInfo.roomType)
        depositLabel.updateText(roomInfo.deposit)
        contractPeriodLabel.updateText(roomInfo.contractPeriod)
        monthlyRentLabel.updateText(roomInfo.monthlyRent)
        managementFeeLabel.updateText(roomInfo.managementFee)
    }
}
