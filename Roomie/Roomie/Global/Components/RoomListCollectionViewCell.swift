//
//  RoomListCollectionCell.swift
//  Roomie
//
//  Created by MaengKim on 1/14/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class RoomListCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UIComponent
    
    private let subtitleStackView = UIStackView()
    private let roomImageView = UIImageView()
    private let monthlyRentLabel = UILabel()
    
    private let moodTagView = UIView()
    let moodTagLabel = UILabel()
    
    let likedImageView = UIImageView()
    
    private let depositLabel = UILabel()
    private let barView = UIView()
    private let termLabel = UILabel()
    
    private let roomTypeLabel = UILabel()
    
    private let roomLocationLabel = UILabel()
    
    // MARK: - UISetting
    
    override var isSelected: Bool {
        didSet{
            self.backgroundColor = isSelected ? .grayscale3 : .clear
        }
    }
    
    override func setStyle() {
        self.layer.cornerRadius = 8
        
        subtitleStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        roomImageView.do {
            $0.layer.cornerRadius = 8
            $0.backgroundColor = .grayscale10
            $0.contentMode = .scaleAspectFill
            $0.isUserInteractionEnabled = false
        }
        
        moodTagView.do {
            $0.backgroundColor = .transpGray160
            $0.layer.cornerRadius = 4
            $0.isUserInteractionEnabled = false
        }
        
        moodTagLabel.do {
            $0.setText(style: .caption2, color: .grayscale12)
            $0.isUserInteractionEnabled = false
        }
        
        likedImageView.do {
            $0.image = .icnHeart24Normal
            $0.isUserInteractionEnabled = false
        }
        
        monthlyRentLabel.do {
            $0.setText(style: .title2, color: .grayscale12)
        }
        
        depositLabel.do {
            $0.setText(style: .body5, color: .primaryPurple)
        }
        
        barView.do {
            $0.frame = CGRect(x: 0, y: 0, width: 1.5, height: 12)
            $0.backgroundColor = .primaryPurple
        }
        
        termLabel.do {
            $0.setText(style: .body5, color: .primaryPurple)
        }
        
        roomTypeLabel.do {
            $0.setText(style: .body4, color: .grayscale6)
        }
        
        roomLocationLabel.do {
            $0.setText(style: .body4, color: .grayscale6)
        }
    }
    
    override func setUI() {
        addSubviews(
            roomImageView,
            likedImageView,
            moodTagView,
            monthlyRentLabel,
            subtitleStackView,
            roomTypeLabel,
            roomLocationLabel
        )
        subtitleStackView.addArrangedSubviews(
            depositLabel,
            barView,
            termLabel
        )
        moodTagView.addSubview(moodTagLabel)
    }
    
    override func setLayout() {
        roomImageView.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(4)
            $0.width.equalTo(140)
            $0.height.equalTo(104)
        }
        
        moodTagView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(22)
        }
        
        moodTagLabel.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
            $0.centerX.equalToSuperview()
        }
        
        likedImageView.snp.makeConstraints{
            $0.top.equalTo(roomImageView.snp.top).offset(6)
            $0.trailing.equalTo(roomImageView.snp.trailing).offset(-6)
            $0.size.equalTo(24)
        }
        
        monthlyRentLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(11)
            $0.leading.equalTo(roomImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(83)
        }
        
        subtitleStackView.snp.makeConstraints{
            $0.top.equalTo(monthlyRentLabel.snp.bottom).offset(2)
            $0.leading.equalTo(roomImageView.snp.trailing).offset(16)
        }
        
        barView.snp.makeConstraints{
            $0.width.equalTo(2)
            $0.height.equalTo(12)
        }
        
        roomTypeLabel.snp.makeConstraints{
            $0.top.equalTo(subtitleStackView.snp.bottom).offset(12)
            $0.leading.equalTo(roomImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        roomLocationLabel.snp.makeConstraints{
            $0.top.equalTo(roomTypeLabel.snp.bottom)
            $0.leading.equalTo(roomImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(30)
        }
    }
}

// MARK: - DataBinding

extension RoomListCollectionViewCell {
    func dataBind(_ data: MapModel) {
        if let image = UIImage(named: data.mainImageURL) {
            roomImageView.image = image
            roomImageView.backgroundColor = .clear
        } else {
            roomImageView.image = nil
            roomImageView.backgroundColor = .grayscale5
        }
        
        likedImageView.image = data.isPinned ? .icnHeartFilledWhite24 : .icnHeartLinewithfillWhite24
        
        moodTagLabel.text = data.moodTag
        monthlyRentLabel.text = "월세 \(data.monthlyRent)"
        depositLabel.text = "보증금 \(data.deposit)"
        termLabel.text = "\(data.contractTerm)개월"
        roomTypeLabel.text = "\(data.occupancyType) · \(data.genderPolicy)"
        roomLocationLabel.text = "\(data.location) · \(data.locationDescription)"
    }
    
    func dataBind(_ data: RecentlyRoom) {
        // TODO: 데이터 연결
        
        if let image = UIImage(named: data.mainImageURL) {
            roomImageView.image = image
            roomImageView.backgroundColor = .clear
        } else {
            roomImageView.image = nil
            roomImageView.backgroundColor = .grayscale5
        }
        
        likedImageView.image = data.isPinned ? .icnHeartFilledWhite24 : .icnHeartLinewithfillWhite24
        
        moodTagLabel.text = data.moodTag
        monthlyRentLabel.text = "월세 \(data.monthlyRent)"
        depositLabel.text = "보증금 \(data.deposit)"
        termLabel.text = "\(data.contractTerm)개월"
        roomTypeLabel.text = "\(data.occupancyType) · \(data.genderPolicy)"
        roomLocationLabel.text = "\(data.location) · \(data.locationDescription)"
    }
    
    func dataBind(_ data: WishListRoom) {
        // TODO: 데이터 연결
        
        if let image = UIImage(named: data.mainImageURL) {
            roomImageView.image = image
            roomImageView.backgroundColor = .clear
        } else {
            roomImageView.image = nil
            roomImageView.backgroundColor = .grayscale5
        }
        
        likedImageView.image = data.isPinned ? .icnHeartFilledWhite24 : .icnHeartLinewithfillWhite24
        
        moodTagLabel.text = data.moodTag
        monthlyRentLabel.text = "월세 \(data.monthlyRent)"
        depositLabel.text = "보증금 \(data.deposit)"
        termLabel.text = "\(data.contractTerm)개월"
        roomTypeLabel.text = "\(data.occupancyType) · \(data.genderPolicy)"
        roomLocationLabel.text = "\(data.location) · \(data.locationDescription)"
    }
    
    func dataBind(_ data: MoodListRoom) {
        // TODO: 데이터 연결
        
        if let image = UIImage(named: data.mainImageURL) {
            roomImageView.image = image
            roomImageView.backgroundColor = .clear
        } else {
            roomImageView.image = nil
            roomImageView.backgroundColor = .grayscale5
        }
        
        likedImageView.image = data.isPinned ? .icnHeartFilledWhite24 : .icnHeartLinewithfillWhite24
        
        moodTagView.isHidden = true
        monthlyRentLabel.text = "월세 \(data.monthlyRent)"
        depositLabel.text = "보증금 \(data.deposit)"
        termLabel.text = "\(data.contractTerm)개월"
        roomTypeLabel.text = "\(data.occupancyType) · \(data.genderPolicy)"
        roomLocationLabel.text = "\(data.location) · \(data.locationDescription)"
    }
}
