//
//  MoodView.swift
//  Roomie
//
//  Created by MaengKim on 1/14/25.
//

import UIKit
import Combine

import CombineCocoa
import Then
import SnapKit

final class MoodButtonView: UIView {
    
    // MARK: - Property
    
    private var cancelBag = CancelBag()
    
    var isSelected: Bool
    
    
    // MARK: - UIComponents
    
    let moodTypeLabel = UILabel()
    private let nextImageView = UIImageView()
    let moodImageView = UIImageView()
    let moodSubLabel = UILabel()
    let moodButton = UIButton()
    
    // MARK: - Initializer
    
    init(_ type: MoodType, image: UIImage, isSelected: Bool = false) {
        self.isSelected = isSelected
        super.init(frame: .zero)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
        
        moodTypeLabel.text = type.title
        moodSubLabel.text = type.subTitle
        moodImageView.image = image
    }
    
    override init(frame: CGRect) {
        self.isSelected = false
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        self.isSelected = false
        super.init(coder: coder)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    // MARK: - UISetting

    private func setStyle() {
        self.do {
            $0.backgroundColor = .primaryLight5
            $0.layer.borderColor = UIColor.primaryLight2.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
        }
        
        moodTypeLabel.do {
            $0.setText(style: .body2, color: .primaryPurple)
        }
        
        nextImageView.do {
            $0.image = .icnArrowRightLine16.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .primaryPurple
        }
        
        moodImageView.do {
            $0.image = .icnDelete20
        }
        
        moodSubLabel.do {
            $0.setText(style: .caption3, color: .primaryPurple)
            $0.numberOfLines = 2
            $0.textAlignment = .left
        }
    }
    
    private func setUI() {
        addSubviews(
            moodTypeLabel,
            nextImageView,
            moodImageView,
            moodSubLabel,
            moodButton
        )
    }
    
    private func setLayout() {
        moodTypeLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(12)
        }
        
        nextImageView.snp.makeConstraints{
            $0.centerY.equalTo(moodTypeLabel)
            $0.trailing.equalToSuperview().inset(8)
            $0.size.equalTo(16)
        }
        
        moodImageView.snp.makeConstraints{
            $0.top.equalTo(moodTypeLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        moodSubLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(12)
        }
        
        moodButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    
    private func setAction() {
        moodButton
            .tapPublisher
            .sink { [weak self] in
                self?.isSelected.toggle()
            }
            .store(in: cancelBag)
    }
}
