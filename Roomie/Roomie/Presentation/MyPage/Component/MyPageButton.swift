//
//  MyPageButton.swift
//  Roomie
//
//  Created by 예삐 on 5/30/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class MyPageButton: UIView {
    
    // MARK: - Property
    
    static let defaultHeight: CGFloat = Screen.height(56)
    
    private let cancelBag = CancelBag()
    
    // MARK: - UIComponent
    
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nextImageView = UIImageView(image: .icnIn)
    private let myPageButton = UIButton()
    
    // MARK: - Initializer

    init(title: String, subtitle: String? = nil) {
        super.init(frame: .zero)
        
        setStyle()
        setUI()
        setLayout()
        setButton()
        dataBind(title: title, subtitle: subtitle)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setButton()
        dataBind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setStyle()
        setUI()
        setLayout()
        setButton()
        dataBind()
    }
    
    private func dataBind(title: String = "", subtitle: String? = nil) {
        titleLabel.updateText(title)
        if subtitle != nil {
            subtitleLabel.updateText(subtitle)
        } else {
            subtitleLabel.isHidden = true
        }
    }
    
    private func setButton() {
        myPageButton
            .controlEventPublisher(for: .touchDown)
            .map { UIColor.grayscale3 }
            .sink { buttonColor in
                self.backgroundColor = buttonColor
            }
            .store(in: cancelBag)
        
        Publishers.MergeMany(
            myPageButton.controlEventPublisher(for: .touchUpInside),
            myPageButton.controlEventPublisher(for: .touchUpOutside),
            myPageButton.controlEventPublisher(for: .touchCancel)
        )
        .map { UIColor.grayscale1 }
        .sink { buttonColor in
            self.backgroundColor = buttonColor
        }
        .store(in: cancelBag)
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        titleStackView.do {
            $0.axis = .vertical
            $0.alignment = .top
            $0.distribution = .fill
            $0.spacing = 4
        }
        
        titleLabel.do {
            $0.setText(style: .body2, color: .grayscale12)
        }
        
        subtitleLabel.do {
            $0.setText(style: .body4, color: .grayscale7)
        }
        
        nextImageView.do {
            $0.image = .icnIn.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .grayscale7
        }
    }
    
    private func setUI() {
        addSubviews(titleStackView, nextImageView, myPageButton)
        titleStackView.addArrangedSubviews(titleLabel, subtitleLabel)
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(MyPageButton.defaultHeight)
        }
        
        titleStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        nextImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(44)
        }
        
        myPageButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
