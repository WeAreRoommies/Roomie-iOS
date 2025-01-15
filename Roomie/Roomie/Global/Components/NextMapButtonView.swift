//
//  NextMapButtonView.swift
//  Roomie
//
//  Created by MaengKim on 1/15/25.
//

import UIKit
import Combine

import CombineCocoa
import Then
import SnapKit

final class NextMapButtonView: UIView {
    
    // MARK: - Property
    
    private var cancelBag = CancelBag()
    
    // MARK: - UIComponents
    
    let titleLabel = UILabel()
    private let nextImageView = UIImageView()
    private let pinImageView = UIImageView()
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
            $0.backgroundColor = .grayscale1
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = UIColor.primaryLight2.cgColor
            $0.layer.borderWidth = 1
        }
        
        titleLabel.do {
            $0.setText("지도에서 더 많은 쉐어하우스 찾기" ,style: .body2, color: .grayscale12)
        }
        
        nextImageView.do {
            $0.image = .icnArrowRightLine24
            $0.tintColor = .grayscale10
        }
        
        pinImageView.do {
            $0.image = .icnMapLine24
            $0.tintColor = .grayscale10
        }
    }
    
    private func setUI() {
        addSubviews(
            titleLabel,
            updateButton,
            nextImageView,
            pinImageView
        )
    }
    
    private func setLayout() {
        pinImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(pinImageView.snp.trailing).offset(4)
        }
        
        nextImageView.snp.makeConstraints{
            $0.size.equalTo(CGSize(width: 24, height: 24))
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
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
            .map { UIColor.grayscale1 }
            .sink { [weak self] backgroundColor in
                self?.backgroundColor = backgroundColor
            }
            .store(in: cancelBag)
        
        updateButton
            .controlEventPublisher(for: .touchDown)
            .map { UIColor.grayscale4 }
            .sink { [weak self] backgroundColor in
                self?.backgroundColor = backgroundColor
            }
            .store(in: cancelBag)
    }
}

