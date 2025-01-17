//
//  WishListEmptyView.swift
//  Roomie
//
//  Created by MaengKim on 1/18/25.
//

import UIKit

import SnapKit
import Then

final class WishListEmptyView: BaseView {
    
    // MARK: - UIComponents
    
    private let emptyImageView = UIImageView()
    
    private let emptyTitleLabel = UILabel()
    
    private let emptySubTitleLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        emptyImageView.do {
            $0.image = .imgSweatGomi
        }
        
        emptyTitleLabel.do {
            $0.setText("찜한 매물이 없어요", style: .heading5, color: .grayscale12)
        }
        
        emptySubTitleLabel.do {
            $0.setText("하트를 눌러 마음에 드는 매물을 찜해보세요", style: .body1, color: .grayscale7)
        }
    }
    
    override func setUI() {
        addSubviews(emptyImageView, emptyTitleLabel, emptySubTitleLabel)
    }
    
    override func setLayout() {
        emptyImageView.snp.makeConstraints{
            $0.size.equalTo(160)
            $0.center.equalToSuperview()
        }
        
        emptyTitleLabel.snp.makeConstraints{
            $0.top.equalTo(emptyImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        emptySubTitleLabel.snp.makeConstraints{
            $0.top.equalTo(emptyTitleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
