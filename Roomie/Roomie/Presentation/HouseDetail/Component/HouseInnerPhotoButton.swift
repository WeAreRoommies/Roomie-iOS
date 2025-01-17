//
//  HouseInnerPhotoButton.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class HouseInnerPhotoButton: UIView {
    
    // MARK: - Property
    
    static let defaultHeight: CGFloat = Screen.height(48)
    
    private var cancelBag = CancelBag()
    
    // MARK: - UIComponent
    
    private let photoIconImageView = UIImageView()
    
    private let titleLabel = UILabel()
    
    private let chevronRigntIconImageView = UIImageView()
    
    private let updateButton = UIButton()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setButtonColor()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setButtonColor()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        self.do {
            $0.backgroundColor = .grayscale1
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.borderWidth = 1
        }
        
        photoIconImageView.do {
            $0.image = .icnImage24
            $0.tintColor = .grayscale10
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.setText("내부 이미지 둘러보기" ,style: .body2, color: .grayscale12)
        }
        
        chevronRigntIconImageView.do {
            $0.image = .icnArrowRightLine24
            $0.tintColor = .grayscale10
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setUI() {
        addSubviews(
            photoIconImageView,
            titleLabel,
            chevronRigntIconImageView,
            updateButton
        )
    }
    
    private func setLayout() {
        photoIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
            $0.size.equalTo(Screen.width(24))
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(photoIconImageView.snp.trailing).offset(8)
        }
        
        chevronRigntIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(Screen.width(24))
        }
        
        updateButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension HouseInnerPhotoButton {
    func setButtonColor() {
        updateButton.controlEventPublisher(for: .touchDown)
            .map { UIColor.grayscale2 }
            .sink { [weak self] buttonColor in
                guard let self else { return }
                self.backgroundColor = buttonColor
            }
            .store(in: cancelBag)
        
        Publishers.MergeMany(
            updateButton.controlEventPublisher(for: .touchUpInside),
            updateButton.controlEventPublisher(for: .touchUpOutside),
            updateButton.controlEventPublisher(for: .touchCancel)
        )
        .map { UIColor.grayscale1 }
        .sink { [weak self] buttonColor in
            guard let self else { return }
            self.backgroundColor = buttonColor
        }
        .store(in: cancelBag)
    }
}
