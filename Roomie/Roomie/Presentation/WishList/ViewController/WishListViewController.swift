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
    
    private let cancelBag = CancelBag()
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    
    private lazy var dataSource = createDiffableDataSource()
    
    final let cellHeight: CGFloat = 112
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let contentInterSpacing: CGFloat = 4
    final let contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 24, right: 16)
    
    private var wishListRooms: [WishListHouse] = WishListHouse.mockHomeData()
    
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
        
        bindViewModel()
        setRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewWillAppearSubject.send()
    }
    
    // MARK: - Functions
    
    override func setView() {
        setNavigationBar(with: "찜 목록")
    }
    
    override func setDelegate() {
        rootView.wishListCollectionView.delegate = self
//        rootView.wishListCollectionView.dataSource = self
    }
}

private extension WishListViewController {
    func setRegister() {
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
    
    func updateEmtpyView() {
        rootView.emptyView.isHidden = !wishListRooms.isEmpty
        rootView.wishListCollectionView.isHidden = wishListRooms.isEmpty
    }
    
    func bindViewModel() {
        let input = WishListViewModel.Input(
            viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.wishList
            .sink { [weak self] data in guard let self else { return }
                self.rootView.emptyView.isHidden = data.isEmpty ? false : true
                self.rootView.wishListCollectionView.isHidden = wishListRooms.isEmpty
                
                if !data.isEmpty {
                    self.updateSnapshot(with: data)
                }
            }
            .store(in: cancelBag)
    }
    
    func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Int, WishListHouse> {
        let dataSource = UICollectionViewDiffableDataSource<Int, WishListHouse> (
            collectionView: rootView.wishListCollectionView,
            cellProvider: {
                collectionView, indexPath, model in guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? HouseListCollectionViewCell else { return UICollectionViewCell()
                }
//                self.updateEmtpyView()
                cell.dataBind(model)
                return cell
            }
        )
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionFooter {
                guard let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: VersionFooterView.reuseIdentifier,
                    for: indexPath
                ) as? VersionFooterView else { return UICollectionReusableView() }
                return footer
            }
            return nil
        }
        return dataSource
    }
    
    func updateSnapshot(with data: [WishListHouse]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, WishListHouse>()
        snapshot.appendSections([0])
        snapshot.appendItems(data, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
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

//extension WishListViewController: UICollectionViewDataSource {
//    func collectionView(
//        _ collectionView: UICollectionView,
//        numberOfItemsInSection section: Int
//    ) -> Int {
//        updateEmtpyView()
//        
//        return wishListRooms.count
//    }
//    
//    func collectionView(
//        _ collectionView: UICollectionView,
//        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier,
//            for: indexPath
//        ) as? HouseListCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        
//        let data = wishListRooms[indexPath.row]
//        cell.dataBind(data)
//        
//        return cell
//    }
//    
//    func collectionView(
//        _ collectionView: UICollectionView,
//        viewForSupplementaryElementOfKind kind: String,
//        at indexPath: IndexPath
//    ) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionFooter else { return UICollectionReusableView() }
//        
//        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: VersionFooterView.reuseIdentifier, for: indexPath) as? VersionFooterView
//        else {
//            return UICollectionReusableView()
//        }
//        
//        return footer
//    }
//}
