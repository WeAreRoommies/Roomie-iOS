//
//  MoodListViewController.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class MoodListViewController: BaseViewController {
    
    // MARK: - Property
    
    let rootView = MoodListView()
    
    private let cancelBag = CancelBag()
    
    private let viewModel: MoodListViewModel
    
    private lazy var dataSource = createDiffableDataSource()
    
    private let moodListTypeSubject = PassthroughSubject<String, Never>()
    
    final let cellHeight: CGFloat = 112
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let contentInterSpacing: CGFloat = 4
    final let contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 24, right: 16)
    
    private let moodType: MoodType
    
    private var moodNavibarTitle: String
    
    // MARK: - Initializer
    
    init(moodType: MoodType) {
        self.moodType = moodType
        self.moodNavibarTitle = moodType.title
        self.viewModel = MoodListViewModel(service: MoodListService())
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
        
        setDelegate()
        setRegister()
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moodListTypeSubject.send(moodType.title)
    }
    
    // MARK: - Functions
    
    override func setView() {
        setNavigationBar(with: "#\(moodNavibarTitle)")
    }
    
    override func setDelegate() {
        rootView.moodListCollectionView.delegate = self
    }
}

// MARK: - Function

private extension MoodListViewController {
    func setRegister() {
        rootView.moodListCollectionView.register(
            HouseListCollectionViewCell.self,
            forCellWithReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier
        )
        
        rootView.moodListCollectionView.register(
            MoodListCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MoodListCollectionHeaderView.reuseIdentifier
        )
        
        rootView.moodListCollectionView.register(
            VersionFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: VersionFooterView.reuseIdentifier
        )
    }
    
    func bindViewModel() {
        let input = MoodListViewModel.Input(
            moodListTypeSubject: moodListTypeSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.moodList
            .receive(on: RunLoop.main)
            .sink { [weak self] data in guard let self else { return }
                if !data.isEmpty {
                    self.updateSnapshot(with: data)
                }
            }
            .store(in: cancelBag)
    }
    
    func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Int, MoodHouse> {
        let dataSource = UICollectionViewDiffableDataSource<Int, MoodHouse> (
            collectionView: rootView.moodListCollectionView, cellProvider: {
                collectionView, indexPath, model in guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? HouseListCollectionViewCell
                else { return UICollectionViewCell() }
                
                cell.dataBind(model)
                return cell
            }
        )
        
        dataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath in if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: MoodListCollectionHeaderView.reuseIdentifier,
                    for: indexPath
                ) as? MoodListCollectionHeaderView else {
                    return UICollectionReusableView()
                }
                header.configure(with: self.moodType)
                return header
            } else if kind == UICollectionView.elementKindSectionFooter {
                guard let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: VersionFooterView.reuseIdentifier,
                    for: indexPath
                ) as? VersionFooterView else {
                    return UICollectionReusableView()
                }
                return footer
            }
            return nil
        }
        return dataSource
    }
    
    func updateSnapshot(with data: [MoodHouse]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MoodHouse>()
        snapshot.appendSections([0])
        snapshot.appendItems(data, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoodListViewController: UICollectionViewDelegateFlowLayout {
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
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 183)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}
