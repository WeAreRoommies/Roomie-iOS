//
//  MapListSheetView.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class MapListSheetView: BaseView {
    private let titleLabel = UILabel()
    
    private let seperatorView = UIView()
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 4
        }
    )
    
    override func setStyle() {
        titleLabel.do {
            $0.setText("매물", style: .title2, color: .grayscale12)
        }
        
        seperatorView.do {
            $0.backgroundColor = .grayscale4
        }
        
        collectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = true
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    override func setUI() {
        addSubviews(titleLabel, seperatorView, collectionView)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
}
