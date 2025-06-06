//
//  MyAccountCellButton.swift
//  Roomie
//
//  Created by 예삐 on 6/5/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class MyAccountCellButton: UIView {
    
    // MARK: - Property
    
    static let defaultHeight: CGFloat = Screen.height(76)
    
    private let cancelBag = CancelBag()
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    let contentLabel = UILabel()
    private let nextImageView = UIImageView()
    private let myAccountButton = UIButton()
    
    // MARK: - Initializer

    init(title: String) {
        super.init(frame: .zero)
        
        setStyle()
        setUI()
        setLayout()
        setButton()
        configure(title: title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setButton()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setStyle()
        setUI()
        setLayout()
        setButton()
        configure()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        titleLabel.do {
            $0.setText(style: .body1, color: .grayscale7)
        }
        
        contentLabel.do {
            $0.setText(style: .body2, color: .grayscale12)
        }
        
        nextImageView.do {
            $0.image = .icnIn.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .grayscale7
        }
    }
    
    private func setUI() {
        addSubviews(titleLabel, contentLabel, nextImageView, myAccountButton)
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(MyAccountCellButton.defaultHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        nextImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(44)
        }
        
        myAccountButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

private extension MyAccountCellButton {
    func setButton() {
        myAccountButton
            .controlEventPublisher(for: .touchDown)
            .map { UIColor.grayscale3 }
            .sink { buttonColor in
                self.backgroundColor = buttonColor
            }
            .store(in: cancelBag)
        
        Publishers.MergeMany(
            myAccountButton.controlEventPublisher(for: .touchUpInside),
            myAccountButton.controlEventPublisher(for: .touchUpOutside),
            myAccountButton.controlEventPublisher(for: .touchCancel)
        )
        .map { UIColor.grayscale1 }
        .sink { buttonColor in
            self.backgroundColor = buttonColor
        }
        .store(in: cancelBag)
    }
    
    func configure(title: String = "") {
        titleLabel.updateText(title)
    }
}
