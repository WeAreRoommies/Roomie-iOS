//
//  MoodCardView.swift
//  Roomie
//
//  Created by MaengKim on 1/14/25.
//

import UIKit
import Combine

import CombineCocoa
import Then
import SnapKit

final class MoodCardView: UIView {
    
    // MARK: - Property
    
    private var cancelBag = CancelBag()
    
    // MARK: - UIComponents
    
    let hashTagLabel = UILabel()
    let moodTypeLabel = UILabel()
    private let nextImageView = UIImageView()
    
    let moodImageView = UIImageView()
    let moodSubLabel = UILabel()
    let moodButton = UIButton()
    
    // MARK: - Initializer
    
    init(_ type: MoodType) {
        super.init(frame: .zero)
        
        setStyle()
        setUI()
        setLayout()
        setMoodButtonView()
        
        moodTypeLabel.text = type.title
        moodSubLabel.text = type.subTitle
        moodImageView.image = type.moodCardViewImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setMoodButtonView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setStyle()
        setUI()
        setLayout()
        setMoodButtonView()
    }
    
    // MARK: - UISetting

    private func setStyle() {
        self.do {
            $0.backgroundColor = .primaryLight5
            $0.layer.borderColor = UIColor.primaryLight2.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
        }
        
        hashTagLabel.do {
            $0.setText("#", style: .body2, color: .primaryPurple)
        }
        
        moodTypeLabel.do {
            $0.setText(style: .body2, color: .primaryPurple)
        }
        
        nextImageView.do {
            $0.image = .icnArrowRightLine16.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .primaryPurple
        }
        
        moodSubLabel.do {
            $0.setText(style: .caption3, color: .primaryPurple)
            $0.numberOfLines = 2
            $0.textAlignment = .left
        }
    }
    
    private func setUI() {
        addSubviews(
            hashTagLabel,
            moodTypeLabel,
            nextImageView,
            moodImageView,
            moodSubLabel,
            moodButton
        )
    }
    
    private func setLayout() {
        hashTagLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(12)
        }
        
        moodTypeLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(hashTagLabel.snp.trailing).offset(4)
        }
        
        nextImageView.snp.makeConstraints{
            $0.centerY.equalTo(moodTypeLabel)
            $0.trailing.equalToSuperview().inset(8)
            $0.size.equalTo(16)
        }
        
        moodSubLabel.snp.makeConstraints{
            $0.top.equalTo(moodTypeLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(18)
        }
        
        moodImageView.snp.makeConstraints{
            $0.top.equalTo(moodSubLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(128).priority(.high)
        }
        
        moodButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    
    private func setMoodButtonView() {
        let pressedEvent = Publishers.MergeMany(
            moodButton.controlEventPublisher(for: .touchCancel),
            moodButton.controlEventPublisher(for: .touchUpInside),
            moodButton.controlEventPublisher(for: .touchUpOutside)
        )
        
        pressedEvent
            .map { UIColor.primaryLight5 }
            .sink { [weak self] backgroundColor in
                self?.backgroundColor = backgroundColor
            }
            .store(in: cancelBag)
        
        moodButton
            .controlEventPublisher(for: .touchDown)
            .map { UIColor.grayscale3 }
            .sink { [weak self] backgroundColor in
                self?.backgroundColor = backgroundColor
            }
            .store(in: cancelBag)
    }
}
