//
//  MoodListView.swift
//  Roomie
//
//  Created by MaengKim on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class MoodListView: BaseView {
    
    // MARK: - UIComponents
    
    let moodListCollectionView: UICollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - UISetting
    
    override func setStyle() {
        moodListCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            $0.collectionViewLayout = layout
            $0.backgroundColor = .grayscale1
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = true
        }
    }
    
    override func setUI() {
        addSubview(moodListCollectionView)
    }
    
    override func setLayout() {
        moodListCollectionView.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
