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
    
    // MARK: - UIComponent

    private let titleLabel = UILabel()
    
    private let seperatorView = UIView()
    
    let fullExcludedButton = UIButton()

    let fullExcludedLabel = UILabel()
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 4
        }
    )
    
    let emptyView = MapListSheetEmptyView()
    
    // MARK: - UISetting

    override func setStyle() {
        titleLabel.do {
            $0.setText("매물", style: .title2, color: .grayscale12)
        }
        
        seperatorView.do {
            $0.backgroundColor = .grayscale4
        }
        
        fullExcludedButton.do {
            $0.setImage(.btnCircleDefault, for: .normal)
        }
        
        fullExcludedLabel.do {
            $0.setText("만실제외", style: .body1, color: .grayscale10)
        }
        
        collectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = true
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    override func setUI() {
        addSubviews(
            titleLabel,
            seperatorView,
            fullExcludedButton,
            fullExcludedLabel,
            collectionView,
            emptyView
        )
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
        
        fullExcludedButton.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(Screen.height(20))
        }
        
        fullExcludedLabel.snp.makeConstraints {
            $0.centerY.equalTo(fullExcludedButton.snp.centerY)
            $0.leading.equalTo(fullExcludedButton.snp.trailing).offset(6)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(fullExcludedButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
