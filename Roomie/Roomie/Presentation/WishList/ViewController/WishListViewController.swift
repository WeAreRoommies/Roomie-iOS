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
    private let pinnedWishSubject = PassthroughSubject<Int, Never>()
    
    private lazy var dataSource = createDiffableDataSource()
    
    final let cellHeight: CGFloat = 112
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let contentInterSpacing: CGFloat = 4
    final let contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 24, right: 16)
    
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
    
    func bindViewModel() {
        let input = WishListViewModel.Input(
            viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher(),
            pinnedWishSubject: pinnedWishSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.wishList
            .receive(on: RunLoop.main)
            .sink { [weak self] data in guard let self else { return }
                self.rootView.emptyView.isHidden = data.isEmpty ? false : true
                self.rootView.wishListCollectionView.isHidden = data.isEmpty
                
                if !data.isEmpty {
                    self.updateSnapshot(with: data)
                }
            }
            .store(in: cancelBag)
        
        output.pinnedWish
            .receive(on: RunLoop.main)
            .sink { [weak self] (houseID, isPinned) in
                guard let self = self else { return }

                if let index = self.viewModel.wishListData.firstIndex(where: { $0.houseID == houseID }) {
                    let indexPath = IndexPath(item: index, section: 0)
                    if let cell = self.rootView.wishListCollectionView.cellForItem(at: indexPath) as? HouseListCollectionViewCell {
                        cell.updateWishButton(isPinned: isPinned)
                    }
                }
            }
            .store(in: cancelBag)
    }
    
    func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Int, WishHouse> {
        let dataSource = UICollectionViewDiffableDataSource<Int, WishHouse> (
            collectionView: rootView.wishListCollectionView,
            cellProvider: {
                collectionView, indexPath, model in guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? HouseListCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                cell.dataBind(model)
                cell.wishButton
                    .controlEventPublisher(for: .touchUpInside)
                    .sink {
                        self.pinnedWishSubject.send(model.houseID)
                    }
                    .store(in: self.cancelBag)
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
    
    func updateSnapshot(with data: [WishHouse]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, WishHouse>()
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
