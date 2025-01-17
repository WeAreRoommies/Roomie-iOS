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
    final let contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 24, right: 16)
    
    private var wishListRooms: [WishListRoom] = WishListRoom.mockHomeData()
    
    // MARK: - Initializer
    
    init(viewModel: WishListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegister()
    }
    
    // MARK: - Functions
    
    override func setView() {
        setNavigationBar(with: "찜 목록")
    }
    
    override func setDelegate() {
        rootView.wishListCollectionView.delegate = self
        rootView.wishListCollectionView.dataSource = self
    }
    
    private func setRegister() {
        rootView.wishListCollectionView.register(
            HouseListCollectionViewCell.self,
            forCellWithReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier
        )
        
        rootView.wishListCollectionView.register(
            VersionFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: VersionFooterView.reuseIdentifier
        )
    }
    
    private func updateEmtpyView() {
        rootView.emptyView.isHidden = !wishListRooms.isEmpty
        rootView.wishListCollectionView.isHidden = wishListRooms.isEmpty
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
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return contentInset
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        // TODO: 상세매물 페이지와 연결
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}

// MARK: - UICollectionViewDataSource

extension WishListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        updateEmtpyView()
        
        return wishListRooms.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? HouseListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = wishListRooms[indexPath.row]
        cell.dataBind(data)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else { return UICollectionReusableView() }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: VersionFooterView.reuseIdentifier, for: indexPath) as? VersionFooterView
        else {
            return UICollectionReusableView()
        }
        
        return footer
    }
}
