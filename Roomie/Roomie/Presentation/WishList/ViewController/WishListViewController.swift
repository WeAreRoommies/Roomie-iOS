//
//  WishListViewController.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class WishListViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = WishListView()
    
    private let viewModel: WishListViewModel
    
    final let cellHeight: CGFloat = 112
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let contentInterSpacing: CGFloat = 4
    
    private var wishListRooms: [WishListRoom] = WishListRoom.mockHomeData()
    
    // MARK: - Initializer
    
    init(viewModel: WishListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    override func setView() {
        setNavigationBar(with: "찜 목록")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setRegister()
    }
    
    override func setDelegate() {
        rootView.wishListCollectionView.delegate = self
        rootView.wishListCollectionView.dataSource = self
    }
    
    private func setRegister() {
        rootView.wishListCollectionView.register(
            RoomListCollectionViewCell.self, forCellWithReuseIdentifier: RoomListCollectionViewCell.reuseIdentifier
        )
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WishListViewController: UICollectionViewDelegateFlowLayout {
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
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return contentInterSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        self.editButtonItem.isSelected = true
        // TODO: 상세매물 페이지와 연결
    }
}

// MARK: - UICollectionViewDataSource

extension WishListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return wishListRooms.count
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
        
        let data = wishListRooms[indexPath.row]
        
        cell.dataBind(
            data.mainImageURL,
            houseId: data.houseID,
            montlyRent: data.monthlyRent,
            deposit: data.deposit,
            occupanyTypes: data.occupancyType,
            location: data.location,
            genderPolicy: data.genderPolicy,
            locationDescription: data.locationDescription,
            isPinned: data.isPinned,
            moodTag: data.moodTag,
            contract_term: data.contractTerm
        )
        return cell
    }
}
