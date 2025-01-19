//
//  HomeEmptyView.swift
//  Roomie
//
//  Created by MaengKim on 1/18/25.
//

import UIKit

import SnapKit
import Then

final class HomeEmptyView: BaseView {
    
    // MARK: - UIComponents
    
    private let emptyTitle = UILabel()
    
    private let emptySubTitle = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        emptyTitle.do {
            $0.setText("최근 본 방이 없어요", style: .heading5, color: .grayscale10)
        }
        
        emptySubTitle.do {
            $0.setText("궁금한 매물이 있다면 확인해보세요", style: .body1, color: .grayscale7)
        }
    }
    
    override func setUI() {
        addSubviews(emptyTitle, emptySubTitle)
    }
    
    override func setLayout() {
        emptyTitle.snp.makeConstraints{
            $0.top.equalToSuperview().inset(84)
            $0.centerX.equalToSuperview()
        }
        
        emptySubTitle.snp.makeConstraints{
            $0.top.equalTo(emptyTitle.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
