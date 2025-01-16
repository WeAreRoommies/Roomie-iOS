//
//  WishListView.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class WishListView: BaseView {
    
    // MARK: - UIComponents
    
    let wishListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isUserInteractionEnabled = true
        
        return collectionView
    }()
    
    let wishListCollectionFooterView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
//    let wishListCollectionView = UICollectionView(
//        frame: .zero,
//        collectionViewLayout: UICollectionViewFlowLayout().then {
//            $0.scrollDirection = .vertical
//        }
//    )
    
//    let wishListCollectionFooterView = UICollectionView(frame: .zero)
    
    // MARK: - UISetting
    
    override func setStyle() {
//        wishListCollectionView.do {
//            $0.backgroundColor = UIColor.clear
//            $0.showsHorizontalScrollIndicator = false
//            $0.showsVerticalScrollIndicator = false
//            $0.isPagingEnabled = true
//            $0.isUserInteractionEnabled = true
//        }
        
//        wishListCollectionFooterView.do {
//
//        }
    }
    
    override func setUI() {
        addSubviews(
            wishListCollectionView,
            wishListCollectionFooterView
        )
    }
    
    override func setLayout() {
        wishListCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        wishListCollectionFooterView.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
