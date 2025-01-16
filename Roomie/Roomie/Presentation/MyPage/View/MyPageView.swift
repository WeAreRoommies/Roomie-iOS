//
//  MyPageView.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import UIKit

import SnapKit
import Then

final class MyPageView: BaseView {
    
    // MARK: - UIComponent

    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: MyPageLayoutHelper.createLayout()
    )
    
    // MARK: - UISetting
    
    override func setUI() {
        addSubview(collectionView)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
