//
//  MoodListView.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class MoodListView: BaseView {
    
    // MARK: - UIComponent
    
    private let moodLabel = UILabel()
    private let subMoodLabel = UILabel()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    private let moodImageView = UIImageView()
    
    let moodListCollectionView: UICollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - UISetting
    
    override func setStyle() {
        moodLabel.do {
            $0.setText(style: .heading5, color: .primaryPurple)
        }
        
        subMoodLabel.do {
            $0.setText(style: .heading5, color: .grayscale12)
        }
        
        titleLabel.do {
            $0.setText(style: .heading5, color: .grayscale12)
        }
        
        subTitleLabel.do {
            $0.setText(style: .body4, color: .grayscale8)
        }
        
        moodListCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            $0.collectionViewLayout = layout
            $0.backgroundColor = UIColor.clear
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.isPagingEnabled = true
            $0.isUserInteractionEnabled = true
        }
    }
    
    override func setUI() {
        addSubviews(
            moodLabel,
            subMoodLabel,
            titleLabel,
            subTitleLabel,
            moodImageView,
            moodListCollectionView
        )
    }
    
    override func setLayout() {
        moodLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        subMoodLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalTo(moodLabel.snp.trailing).offset(4)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(moodLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
        }
        
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        moodImageView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalTo(subMoodLabel.snp.trailing).offset(23)
        }
        
        moodListCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(183)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            
        }
    }
}
