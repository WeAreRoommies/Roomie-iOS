//
//  MyAccountLinkCellButton.swift
//  Roomie
//
//  Created by 예삐 on 6/5/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class MyAccountTypeView: BaseView {
    
    // MARK: - Property
    
    static let defaultHeight: CGFloat = Screen.height(76)
    
    private let cancelBag = CancelBag()
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    private let contentStackView = UIStackView()
    private let contentImageView = UIImageView()
    private let contentLabel = UILabel()
    
    // MARK: - Initializer

    init(socialType: SocialType) {
        super.init(frame: .zero)
        
        setStyle()
        setUI()
        setLayout()
        configure(socialType: socialType)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setStyle()
        setUI()
        setLayout()
        configure()
    }
    
    // MARK: - UISetting
    
    override func setStyle() {
        titleLabel.do {
            $0.setText("계정 연동", style: .body1, color: .grayscale7)
        }
        
        contentStackView.do {
            $0.axis = .horizontal
            $0.alignment = .top
            $0.distribution = .fill
            $0.spacing = 8
        }
        
        contentLabel.do {
            $0.setText(style: .body2, color: .grayscale12)
        }
    }
    
    override func setUI() {
        addSubviews(titleLabel, contentStackView)
        contentStackView.addArrangedSubviews(contentImageView, contentLabel)
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(MyAccountTypeView.defaultHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        contentStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
        }
    }
}

private extension MyAccountTypeView {
    func configure(socialType: SocialType = .apple) {
        contentImageView.image = (socialType == .apple) ? .icnApple : .icnKakao
        contentLabel.updateText((socialType == .apple) ? "Apple" : "카카오톡")
    }
}
