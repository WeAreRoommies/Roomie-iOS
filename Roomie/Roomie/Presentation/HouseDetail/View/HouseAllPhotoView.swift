//
//  HouseAllPhotoView.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import UIKit

import SnapKit
import Then

final class HouseAllPhotoView: BaseView {
    
    // MARK: - UIComponent
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // 대표시설
    private let mainTitleLabel = UILabel()
    private let mainBackView = UIView()
    let mainImageView = UIImageView()
    let mainDescriptionLabel = UILabel()
    
    // 공용시설
    private let facilityTitleLabel = UILabel()
    private let facilityBackView = UIView()
    let facilityImageView = UIImageView()
    let facilityDescriptionLabel = UILabel()
    
    // 각 방 시설
    private let roomTitleLabel = UILabel()
    private let roomStackView = UIStackView()
    
    // 평면도
    private let floorTitleLabel = UILabel()
    private let floorBackView = UIView()
    let floorImageView = UIImageView()
    
    // MARK: - UISetting
    
    override func setStyle() {
        mainTitleLabel.do {
            $0.setText("대표사진", style: .heading5, color: .grayscale12)
        }
        
        mainBackView.do {
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        mainImageView.do {
            $0.backgroundColor = .grayscale5
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
        
        mainDescriptionLabel.do {
            $0.setText("설명설명", style: .body4, color: .grayscale12)
        }
        
        facilityTitleLabel.do {
            $0.setText("공용시설", style: .heading5, color: .grayscale12)
        }
        
        facilityBackView.do {
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        facilityImageView.do {
            $0.backgroundColor = .grayscale5
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
        
        facilityDescriptionLabel.do {
            $0.setText(style: .body4, color: .grayscale12)
        }
        
        roomTitleLabel.do {
            $0.setText("각 방 시설", style: .heading5, color: .grayscale12)
        }
        
        roomStackView.do {
            $0.axis = .vertical
            $0.spacing = 12
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        floorTitleLabel.do {
            $0.setText("평면도", style: .heading5, color: .grayscale12)
        }
        
        floorBackView.do {
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        floorImageView.do {
            $0.backgroundColor = .grayscale5
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
    }
    
    override func setUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
                mainTitleLabel,
                mainBackView,
                facilityTitleLabel,
                facilityBackView,
                roomTitleLabel,
                roomStackView,
                floorTitleLabel,
                floorBackView
            )
        
        mainBackView.addSubviews(mainImageView, mainDescriptionLabel)
        
        facilityBackView.addSubviews(facilityImageView, facilityDescriptionLabel)
        
        floorBackView.addSubview(floorImageView)
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        mainBackView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        mainImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(Screen.height(192))
        }
        
        mainDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        facilityTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainBackView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        facilityBackView.snp.makeConstraints {
            $0.top.equalTo(facilityTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        facilityImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(Screen.height(192))
        }
        
        facilityDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(facilityImageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        roomTitleLabel.snp.makeConstraints {
            $0.top.equalTo(facilityBackView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        roomStackView.snp.makeConstraints {
            $0.top.equalTo(roomTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        floorTitleLabel.snp.makeConstraints {
            $0.top.equalTo(roomStackView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        floorBackView.snp.makeConstraints {
            $0.top.equalTo(floorTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        floorImageView.snp.makeConstraints {
            $0.height.equalTo(Screen.height(192))
            $0.edges.equalToSuperview().inset(8)
        }
    }
}

extension HouseAllPhotoView {
    func fetchRooms(_ rooms: [HouseDetailRoom]) {
        roomStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for index in 0..<rooms.count {
            let expendView = RoomFacilityExpandView(
                title: rooms[index].name,
                status: rooms[index].status
            )
            expendView.dataBind(rooms[index].facility)
            expendView.configure(rooms[index].mainImageURL[0])
            roomStackView.addArrangedSubview(expendView)
        }
    }
}
