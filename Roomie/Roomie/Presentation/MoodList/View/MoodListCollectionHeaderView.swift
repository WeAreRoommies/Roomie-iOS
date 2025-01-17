//
//  MoodListView.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class MoodListCollectionHeaderView: BaseCollectionReusableView {
    
    // MARK: - Property
    
    private var cancelBag = CancelBag()
    
    // MARK: - UIComponent
    
    private let hashTagLabel = UILabel()
    private let moodLabel = UILabel()
    
    private let subMoodLabel = UILabel()
    
    private let titleLabel = UILabel()
    
    private let subTitleMoodLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    private let moodImageView = UIImageView()
    
    // MARK: - UISetting
    
    override func setStyle() {
        hashTagLabel.do {
            $0.setText("#", style: .heading5, color: .primaryPurple)
        }
        
        moodLabel.do {
            $0.setText(style: .heading5, color: .primaryPurple)
        }
        
        subMoodLabel.do {
            $0.setText("집 찾으신다면", style: .heading5, color: .grayscale12)
        }
        
        titleLabel.do {
            $0.setText("이 집은 어때요?", style: .heading5, color: .grayscale12)
        }
        
        subTitleMoodLabel.do {
            $0.setText(style: .body4, color: .grayscale8)
        }
        
        subTitleLabel.do {
            $0.setText("이 돋보이는 집 리스트예요", style: .body4, color: .grayscale8)
        }
    }
    
    override func setUI() {
        addSubviews(
            hashTagLabel,
            moodLabel,
            subMoodLabel,
            titleLabel,
            subTitleMoodLabel,
            subTitleLabel,
            moodImageView
        )
    }
    
    override func setLayout() {
        hashTagLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        moodLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalTo(hashTagLabel.snp.trailing)
        }
        
        subMoodLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalTo(moodLabel.snp.trailing).offset(4)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(moodLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
        }
        
        subTitleMoodLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(subTitleMoodLabel.snp.trailing)
        }
        
        moodImageView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(160)
        }
    }
    
    func configure(with type: MoodType) {
        moodLabel.text = type.title
        subTitleMoodLabel.text = type.subTitleMood
        moodImageView.image = type.moodListViewImage
    }
}
