//
//  HomeView.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//
import UIKit

import Then
import SnapKit

final class HomeView: BaseView {

    // MARK: - UIComponents
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let nameLabel = UILabel()
    private let greetingLabel = UILabel()
    private let subGreetingLabel = UILabel()
    private let roomieImageView = UIImageView()
    
    let updateButton = UpdateButtonView()
    
    private let moodView = UIView()
    private let moodLabel = UILabel()
    private let moodStackView = UIStackView()
    let calmCardView = MoodButtonView(.calm, image: .icnDelete20)
    let livelyCardView = MoodButtonView(.lively, image: .icnDelete20)
    let neatCardView = MoodButtonView(.neat, image: .icnDelete20)
    
    private let recentlyLabel = UILabel()

    
    // MARK: - UISetting
    
    override func setStyle() {
        self.backgroundColor = .primaryLight4
        
        nameLabel.do {
            $0.setText("맹수님," ,style: .heading2, color: .primaryPurple)
        }
        greetingLabel.do {
            $0.setText("루미에 어서오세요!" ,style: .heading2, color: .grayscale12)
        }
        subGreetingLabel.do {
            $0.setText("루미가 루미님의 완벽한 집을\n찾아드릴게요" ,style: .body4, color: .grayscale7)
            $0.numberOfLines = 2
        }
        roomieImageView.do {
            $0.image = .icnDelete20
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
    }
    
    override func setUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            nameLabel,
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
            recentlyLabel
        )
        moodStackView.addArrangedSubviews(
            calmCardView,
            livelyCardView,
            neatCardView
        )
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.high)
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(31)
            $0.leading.equalToSuperview().inset(20)
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
            $0.top.equalToSuperview().inset(31)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(CGSize(width: 20, height: 20))
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
    }
}
