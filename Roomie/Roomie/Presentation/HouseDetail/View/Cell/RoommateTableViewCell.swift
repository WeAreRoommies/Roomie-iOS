//
//  RoommateTableViewCell.swift
//  Roomie
//
//  Created by 김승원 on 1/21/25.
//

import UIKit

import SnapKit
import Then

final class RoommateTableViewCell: BaseTableViewCell {
    
    // MARK: - UIComponent
    
    private let backView = UIView()
    
    private let profileImageView = UIImageView()
    
    private let ageLabel = UILabel()
    private let jobLabel = UILabel()
    
    private let mbtiBackView = UIView()
    private let mbtiLabel = UILabel()
    
    private let roomNameBackView = UIView()
    private let roomNameLabel = UILabel()
    
    private let sleepTimeTitleLabel = UILabel()
    private let sleepTimeLabel = UILabel()
    
    private let activityTimeTitleLabel = UILabel()
    private let activityTimeLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        backView.do {
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.clipsToBounds = true
        }
        
        profileImageView.do {
            $0.backgroundColor = .grayscale5
            $0.image = .imgProfile
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = Screen.width(65) / 2
            $0.clipsToBounds = true
        }
        
        ageLabel.do {
            $0.setText("20대 초반", style: .body2, color: .grayscale12)
        }
        
        jobLabel.do {
            $0.setText("대학생", style: .body2, color: .grayscale12)
        }
        
        mbtiBackView.do {
            $0.backgroundColor = .grayscale4
            $0.layer.cornerRadius = 2
            $0.clipsToBounds = true
        }
        
        mbtiLabel.do {
            $0.setText("INFP", style: .caption1, color: .grayscale8)
        }
        
        roomNameBackView.do {
            $0.backgroundColor = .grayscale4
            $0.layer.cornerRadius = 2
            $0.clipsToBounds = true
        }
        
        roomNameLabel.do {
            $0.setText("1A 싱글침대", style: .caption1, color: .grayscale8)
        }
        
        sleepTimeTitleLabel.do {
            $0.setText("수면시간", style: .body6, color: .grayscale8)
        }
        
        sleepTimeLabel.do {
            $0.setText("21:00 - 21:00", style: .body4, color: .grayscale10)
        }
        
        activityTimeTitleLabel.do {
            $0.setText("활동시간", style: .body6, color: .grayscale8)
        }
        
        activityTimeLabel.do {
            $0.setText("21:00 - 21:00", style: .body4, color: .grayscale10)
        }
    }
    
    override func setUI() {
        addSubview(backView)
        
        backView.addSubviews(
            profileImageView,
            ageLabel,
            jobLabel,
            mbtiBackView,
            roomNameBackView,
            sleepTimeTitleLabel,
            sleepTimeLabel,
            activityTimeTitleLabel,
            activityTimeLabel
        )
        
        mbtiBackView.addSubview(mbtiLabel)
        
        roomNameBackView.addSubview(roomNameLabel)
    }
    
    override func setLayout() {
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(Screen.width(65))
        }
        
        ageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        jobLabel.snp.makeConstraints {
            $0.top.equalTo(ageLabel.snp.top)
            $0.leading.equalTo(ageLabel.snp.trailing).offset(Screen.width(2))
        }
        
        mbtiBackView.snp.makeConstraints {
            $0.leading.equalTo(jobLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(jobLabel.snp.centerY)
        }
        
        mbtiLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(2)
            $0.horizontalEdges.equalToSuperview().inset(4)
        }
        
        roomNameBackView.snp.makeConstraints {
            $0.leading.equalTo(mbtiBackView.snp.trailing).offset(4)
            $0.centerY.equalTo(jobLabel.snp.centerY)
        }
        
        roomNameLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(2)
            $0.horizontalEdges.equalToSuperview().inset(4)
        }
        
        sleepTimeTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(activityTimeTitleLabel.snp.top).offset(-4)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        sleepTimeLabel.snp.makeConstraints {
            $0.bottom.equalTo(activityTimeTitleLabel.snp.top).offset(-4)
            $0.leading.equalTo(sleepTimeTitleLabel.snp.trailing).offset(4)
        }
        
        activityTimeTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        activityTimeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalTo(activityTimeTitleLabel.snp.trailing).offset(4)
        }
    }
}
