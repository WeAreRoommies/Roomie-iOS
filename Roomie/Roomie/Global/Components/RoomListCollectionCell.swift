//
//  RoomListCollectionCell.swift
//  Roomie
//
//  Created by MaengKim on 1/14/25.
//

import UIKit

import SnapKit
import Then

final class RoomListCollectionCell: BaseCollectionReusableView {
    
    // MARK: - Property
    
    var itemRow: Int?
    
    // MARK: - UIComponent
    
    private let cellView = UIView()
    
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
    
    override func setStyle() {
        subtitleStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        roomImageView.do {
            $0.layer.cornerRadius = 8
            $0.backgroundColor = .grayscale10
        }
        
        moodTagView.do {
            $0.backgroundColor = .transpGray160
            $0.layer.cornerRadius = 4
        }
        
        moodTagLabel.do {
            $0.setText(style: .caption2, color: .grayscale12)
        }
        
        likedImageView.do {
            $0.image = .icnHeart24Normal
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
        cellView.addSubviews(
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
            $0.top.leading.bottom.equalToSuperview()
            $0.size.equalTo(CGSize(width: 140, height: 104))
        }
        
        moodTagView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(6)
            $0.top.equalToSuperview().inset(6)
        }
        
        likedImageView.snp.makeConstraints{
            $0.leading.equalTo(moodTagView.snp.trailing).offset(56)
            $0.top.equalToSuperview().inset(6)
        }
        
        monthlyRentLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(7)
            $0.leading.equalTo(roomImageView.snp.trailing).offset(16)
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
        }
        
        roomLocationLabel.snp.makeConstraints{
            $0.top.equalTo(roomTypeLabel.snp.bottom)
            $0.leading.equalTo(roomImageView.snp.trailing).offset(16)
        }
    }
    
    // MARK: - Functions
    
    func configure(with home: HomeModel) {
        
    }
}
