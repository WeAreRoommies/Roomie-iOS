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
            switch sectionIndex {
            default:
                layoutSection = createHousePhotoLayout()
                return layoutSection
            }
        }
        return layout
    }
    
    // MARK: - DataSource 설정
    
    /// DataSource를 설정하는 함수입니다.
    /// ViewController에서 호출합니다.
    static func configureDataSource(for collectionView: UICollectionView, with mockData: [HouseDetailModel]) -> UICollectionViewDiffableDataSource<HouseDetailSection, HouseDetailModel> {
        
        // cell provider 구현
        let dataSource = UICollectionViewDiffableDataSource<HouseDetailSection, HouseDetailModel>(
            collectionView: collectionView
        ) { collectionView, indexPath, item in
            
            switch HouseDetailSection(rawValue: indexPath.section) {
                
            case .housePhoto:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HousePhotoCell.reuseIdentifier,
                    for: indexPath
                ) as? HousePhotoCell else {
                    return UICollectionViewCell()
                }
                return cell
                
            default:
                return nil
            }
        }
        
        // header
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let section = HouseDetailSection(rawValue: indexPath.section) else { return nil }
            
            switch section {
            case .housePhoto:
                return nil
            }
            
//            switch section {
//            case .first:
//                if kind == FirstHeaderView.firstHeaderElementKind {
//                    guard let headerView = collectionView.dequeueReusableSupplementaryView(
//                        ofKind: kind,
//                        withReuseIdentifier: FirstHeaderView.identifier,
//                        for: indexPath
//                    ) as? FirstHeaderView else { return UICollectionReusableView() }
//                    return headerView
//                } else {
//                    return UICollectionReusableView()
//                }
//            }
        }
        
        return dataSource
    }
    
    // MARK: - Snapshot 설정
    
    /// Snapshot을 설정하는 함수입니다.
    /// ViewController에서 호출합니다.
    static func applySnapshot(for dataSource: UICollectionViewDiffableDataSource<HouseDetailSection, HouseDetailModel>, with mockData: [HouseDetailModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<HouseDetailSection, HouseDetailModel>()
        snapshot.appendSections([.housePhoto])
        snapshot.appendItems(mockData, toSection: .housePhoto)
        dataSource.apply(snapshot, animatingDifferences: true)
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
}
