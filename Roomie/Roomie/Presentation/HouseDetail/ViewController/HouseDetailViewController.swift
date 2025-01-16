//
//  HouseDetailViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa

final class HouseDetailViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = HouseDetailView()
    
    private let houseDetailData = HouseDetailModel.mockData()
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegister()
    }
    
    override func setDelegate() {
        rootView.collectionView.dataSource = self
    }
    
    private func setRegister() {
        rootView.collectionView.register(HousePhotoCell.self, forCellWithReuseIdentifier: HousePhotoCell.reuseIdentifier)
        rootView.collectionView.register(HouseInfoCell.self, forCellWithReuseIdentifier: HouseInfoCell.reuseIdentifier)
    }
}

extension HouseDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HouseDetailSection.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch HouseDetailSection(rawValue: section) {
        case .housePhoto:
            return 1
        case .houseInfo:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch HouseDetailSection(rawValue: indexPath.section) {
        case .housePhoto:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HousePhotoCell.reuseIdentifier,
                for: indexPath
            )
            // 필요한 데이터 설정
            return cell
        case .houseInfo:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HouseInfoCell.reuseIdentifier,
                for: indexPath
            )
            // 데이터를 셀에 설정 (예: houseDetailData[indexPath.row]의 값을 설정)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
