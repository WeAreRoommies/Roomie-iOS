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
}

final class HouseDetailView: BaseView {
    
    // MARK: - UIComponent
    
    lazy var collectionView = UICollectionView(frame: bounds, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - UISetting
    
    override func setStyle() {
        collectionView.do {
            $0.backgroundColor = .blue
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
