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
    
    private var dataSource: UICollectionViewDiffableDataSource<HouseDetailSection, HouseDetailModel>!
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        applySnapshot()
        setRegister()
    }
    
    private func setRegister() {
        rootView.collectionView.register(HousePhotoCell.self, forCellWithReuseIdentifier: HousePhotoCell.reuseIdentifier)
    }
    
    // MARK: - DataSource 설정
    
    private func configureDataSource() {
        dataSource = HouseDetailLayoutHelper.configureDataSource(
            for: rootView.collectionView,
            with: HouseDetailModel.mockData()
        )
    }
    
    // MARK: - Snapshot 업데이트
    
    private func applySnapshot() {
        HouseDetailLayoutHelper.applySnapshot(for: dataSource, with: HouseDetailModel.mockData())
    }
    
    
}
