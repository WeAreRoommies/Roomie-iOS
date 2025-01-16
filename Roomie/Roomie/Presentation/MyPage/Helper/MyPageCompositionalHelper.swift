//
//  MyPageCompositionalHelper.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit

enum MyPageCompositionalHelper {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            (sectionNumber, _ environment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            switch sectionNumber {
            case 0:
                section = createPlusSection()
            default:
                section = createServiceSection()
            }
            return section
        }
    }
    
    static func createPlusSection() -> NSCollectionLayoutSection {
        var defaultEdgeInsets: NSDirectionalEdgeInsets {
            return NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
        
        let defaultSize = NSCollectionLayoutSize(
            widthDimension: .absolute(UIScreen.main.bounds.width),
            heightDimension: .absolute(60)
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(160)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: defaultSize)
        item.contentInsets = defaultEdgeInsets
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: defaultSize, subitems: [item])
        group.contentInsets = defaultEdgeInsets
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = defaultEdgeInsets
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        return section
    }
    
    static func createServiceSection() -> NSCollectionLayoutSection {
        var defaultEdgeInsets: NSDirectionalEdgeInsets {
            return NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
        
        let defaultSize = NSCollectionLayoutSize(
            widthDimension: .absolute(UIScreen.main.bounds.width),
            heightDimension: .absolute(60)
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(56)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: defaultSize)
        item.contentInsets = defaultEdgeInsets
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: defaultSize, subitems: [item])
        group.contentInsets = defaultEdgeInsets
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = defaultEdgeInsets
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        return section
    }
}
