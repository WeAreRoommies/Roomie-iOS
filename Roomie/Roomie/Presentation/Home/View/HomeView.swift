//
//  HomeView.swift
//  Roomie
//
//  Created by MaengKim on 1/7/25.
//

import UIKit

import Then
import SnapKit

final class HomeView: BaseView {

    // MARK: - UIComponents
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    let gradientView = UIView()
    
    let emptyView = HomeEmptyView()
    
    var nameLabel = UILabel()
    private let nameTitleLabel = UILabel()
    
    private let greetingLabel = UILabel()
    private let subGreetingLabel = UILabel()
    private let roomieImageView = UIImageView()
    
    let updateButton = AppleLoverClub()
    
    private let moodView = UIView()
    private let moodLabel = UILabel()
    private let moodStackView = UIStackView()
    let calmCardView = MoodCardView(.calm)
    let livelyCardView = MoodCardView(.lively)
    let neatCardView = MoodCardView(.neat)
    
    private let recentlyLabel = UILabel()
    
    let roomListCollectionView: UICollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    )

    let nextMapView = ShowMapButton()
    
    // MARK: - UISetting
    
    override func setStyle() {
        nameLabel.do {
            $0.setText(style: .heading2, color: .primaryPurple)
        }
        
        nameTitleLabel.do {
            $0.setText("님,", style: .heading2, color: .grayscale12)
        }
        
        greetingLabel.do {
            $0.setText("루미에 어서오세요!" ,style: .heading2, color: .grayscale12)
        }
        subGreetingLabel.do {
            $0.setText("루미가 루미님의 완벽한 집을\n찾아드릴게요" ,style: .body4, color: .grayscale7)
            $0.numberOfLines = 2
        }
        roomieImageView.do {
            $0.image = .imgHomeGomi
        }
        
        contentView.do {
            $0.isUserInteractionEnabled = true
        }
        
        moodView.do {
            $0.backgroundColor = .grayscale1
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        moodStackView.do {
            $0.spacing = 8
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }
        
        moodLabel.do {
            $0.setText("분위기 별로 보기" ,style: .heading5, color: .grayscale12)
        }
        
        recentlyLabel.do {
            $0.setText("최근 본 방" ,style: .heading5, color: .grayscale12)
        }
        
        roomListCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            $0.collectionViewLayout = layout
            $0.backgroundColor = UIColor.clear
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.isPagingEnabled = false
            $0.isUserInteractionEnabled = true
        }
        
        emptyView.do {
            $0.isHidden = true
        }
    }
    
    override func setUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            gradientView,
            nameLabel,
            nameTitleLabel,
            greetingLabel,
            updateButton,
            subGreetingLabel,
            roomieImageView,
            updateButton,
            moodView
        )
        moodView.addSubviews(
            moodLabel,
            moodStackView,
            recentlyLabel,
            roomListCollectionView,
            emptyView,
            nextMapView
        )
        moodStackView.addArrangedSubviews(
            calmCardView,
            livelyCardView,
            neatCardView
        )
    }
    
    override func setLayout() {
        gradientView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.low)
            $0.width.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(41)
            $0.leading.equalToSuperview().inset(20)
        }
        
        nameTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(41)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
        }
        
        greetingLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        subGreetingLabel.snp.makeConstraints{
            $0.top.equalTo(greetingLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        roomieImageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(180)
            $0.width.equalTo(240)
        }
        
        updateButton.snp.makeConstraints{
            $0.top.equalTo(subGreetingLabel.snp.bottom).offset(58)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        moodView.snp.makeConstraints{
            $0.top.equalTo(updateButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(contentView)
        }
        
        moodLabel.snp.makeConstraints{                  
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(20)
        }
        
        moodStackView.snp.makeConstraints{
            $0.top.equalTo(moodLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        calmCardView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        livelyCardView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        neatCardView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        recentlyLabel.snp.makeConstraints{
            $0.top.equalTo(calmCardView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        
        roomListCollectionView.snp.makeConstraints{
            $0.top.equalTo(recentlyLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(0)
        }
        
        emptyView.snp.makeConstraints{
            $0.top.equalTo(recentlyLabel.snp.bottom).offset(12)
            $0.bottom.equalTo(nextMapView.snp.top).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextMapView.snp.makeConstraints{
            $0.top.equalTo(roomListCollectionView.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
