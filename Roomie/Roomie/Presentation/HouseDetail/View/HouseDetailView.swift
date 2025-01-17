//
//  HouseDetailView.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import UIKit

import SnapKit
import Then

enum HouseDetailSection: Int, CaseIterable {
    case housePhoto
    case houseInfo
    case roomMood
}

final class HouseDetailView: BaseView {
    
    // MARK: - UIComponent
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - UISetting
    
    override func setStyle() {
        collectionView.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.collectionViewLayout = HouseDetailLayoutHelper.createCompositionalLayout()
        }
    }
    
    override func setUI() {
        addSubview(collectionView)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
