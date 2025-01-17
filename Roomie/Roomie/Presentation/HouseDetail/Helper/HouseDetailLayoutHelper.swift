//
//  HouseDetailLayoutHelper.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import UIKit

final class HouseDetailLayoutHelper {
    
    // MARK: - Compositional Layout 생성
    
    /// CompositionalLayout을 생성하는 함수입니다.
    /// View에서 collectionView의 collectionViewLayout 인자값으로 전달합니다.
    static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (
            sectionIndex: Int,
            environment: NSCollectionLayoutEnvironment
        ) -> NSCollectionLayoutSection? in
            let layoutSection: NSCollectionLayoutSection
            
            guard let section = HouseDetailSection(rawValue: sectionIndex) else {
                return nil
            }
            
            switch section {
            case .housePhoto:
                layoutSection = createHousePhotoLayout()
            case .houseInfo:
                layoutSection = createHouseInfoLayout()
            }
            
            return layoutSection
        }
        return layout
    }
}

// MARK: - Layout 관련 private extension

private extension HouseDetailLayoutHelper {
    // 첫 번째 섹션 레이아웃
    static func createHousePhotoLayout() -> NSCollectionLayoutSection {
        
        // item
        let itemInset: CGFloat = 0
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: itemInset,
            leading: itemInset,
            bottom: itemInset,
            trailing: itemInset
        )
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Screen.height(312))
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
//        // header
//        let headerSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .absolute(50)
//        )
//        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: FirstHeaderView.firstHeaderElementKind,
//            alignment: .top
//        )
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        //        section.boundarySupplementaryItems = [headerElement]
        return section
    }
    
    static func createHouseInfoLayout() -> NSCollectionLayoutSection {
        
        // item
        let itemInset: CGFloat = 0
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: itemInset,
            leading: itemInset,
            bottom: itemInset,
            trailing: itemInset
        )
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Screen.height(290))
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
