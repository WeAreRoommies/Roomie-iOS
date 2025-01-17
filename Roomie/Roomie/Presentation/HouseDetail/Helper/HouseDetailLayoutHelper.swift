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
            case .roomMood:
                layoutSection = createRoomMoodLayout()
            }
            
            return layoutSection
        }
        return layout
    }
}

private extension HouseDetailLayoutHelper {
    static func createHousePhotoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Screen.height(312))
        )
        let groupInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = groupInsets
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    static func createHouseInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Screen.height(290))
        )
        let groupInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = groupInsets
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    static func createRoomMoodLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(Screen.height(344))
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let groupInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 28, trailing: 20)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = groupInsets
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerElement]
        return section
    }
}
