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
    
    let wishListCollectionView: UICollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    let emptyView = WishListEmptyView()
    
    // MARK: - UISetting
    
    override func setStyle() {
        wishListCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.sectionFootersPinToVisibleBounds = true
            layout.footerReferenceSize = .zero
            
            $0.collectionViewLayout = layout
            $0.backgroundColor = .grayscale1
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = true
        }
        
        emptyView.do {
            $0.isHidden = true
        }
    }
    
    override func setUI() {
        addSubviews(emptyView, wishListCollectionView)
    }
    
    override func setLayout() {
        wishListCollectionView.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        emptyView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
