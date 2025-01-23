//
//  AppleLoverClub.swift
//  Roomie
//
//  Created by MaengKim on 1/14/25.
//

import UIKit
import Combine

import CombineCocoa
import Then
import SnapKit

final class AppleLoverClub: UIView {
    
    // MARK: - Property
    
    private var cancelBag = CancelBag()
    
    // MARK: - UIComponents
    
    let titleLabel = UILabel()
    private let nextImageView = UIImageView()
    let updateButton = UIButton()
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setUpdateButtonView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setStyle()
        setUI()
        setLayout()
        setUpdateButtonView()
    }
    
    // MARK: - UISetting

    private func setStyle() {
        self.do {
            $0.backgroundColor = .transpGray160
            $0.layer.cornerRadius = 8
        }
        
        titleLabel.do {
            $0.setText("1분만에 나의 분위기 알아보기" ,style: .body2, color: .grayscale10)
        }
        
        nextImageView.do {
            $0.image = .icnArrowRightLine24
        }
    }
    
    private func setUI() {
        addSubviews(
            titleLabel,
            updateButton,
            nextImageView
        )
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        nextImageView.snp.makeConstraints{
            $0.size.equalTo(CGSize(width: 20, height: 20))
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        updateButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func setUpdateButtonView() {
        let pressedEvent = Publishers.MergeMany(
            updateButton.controlEventPublisher(for: .touchCancel),
            updateButton.controlEventPublisher(for: .touchUpInside),
            updateButton.controlEventPublisher(for: .touchUpOutside)
        )
        
        pressedEvent
            .map { UIColor.transpGray160 }
            .sink { [weak self] backgroundColor in
                self?.backgroundColor = backgroundColor
            }
            .store(in: cancelBag)
        
        updateButton
            .controlEventPublisher(for: .touchDown)
            .map { UIColor.grayscale3 }
            .sink { [weak self] backgroundColor in
                self?.backgroundColor = backgroundColor
            }
            .store(in: cancelBag)
    }
}

