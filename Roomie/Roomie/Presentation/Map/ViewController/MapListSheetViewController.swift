//
//  MapListSheetViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit
import Combine

final class MapListSheetViewController: BaseViewController {
    private let rootView = MapListSheetView()
    
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let cellHeight: CGFloat = 112
    final let contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    private var mapListData: [MapModel] = MapModel.mockMapData()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegister()
    }
    
    override func setDelegate() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
    }
}

private extension MapListSheetViewController {
    func setRegister() {
        rootView.collectionView.register(
            RoomListCollectionViewCell.self,
            forCellWithReuseIdentifier: RoomListCollectionViewCell.reuseIdentifier
        )
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MapListSheetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return contentInset
    }
}

// MARK: - UICollectionViewDataSource

extension MapListSheetViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return mapListData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RoomListCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? RoomListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = mapListData[indexPath.row]
        cell.dataBind(data)
        
        return cell
    }
}
