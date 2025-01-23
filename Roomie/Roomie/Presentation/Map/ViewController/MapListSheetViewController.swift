//
//  MapListSheetViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit
import Combine

final class MapListSheetViewController: BaseViewController {
    
    // MARK: - Property

    private let rootView = MapListSheetView()
    
    private let viewModel: MapViewModel
    
    private let cancelBag = CancelBag()
    
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let cellHeight: CGFloat = 112
    final let contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    private let pinnedHouseIDSubject = PassthroughSubject<Int, Never>()
    
    private lazy var dataSource = createDiffableDataSource()
    
    // MARK: - Initializer

    init(viewModel: MapViewModel) {
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
        bindViewModel()
    }
    
    // MARK: - Functions
    
    override func setDelegate() {
        rootView.collectionView.delegate = self
    }
}

private extension MapListSheetViewController {
    func setRegister() {
        rootView.collectionView.register(
            HouseListCollectionViewCell.self,
            forCellWithReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier
        )
    }
    
    func bindViewModel() {
        let input = MapViewModel.Input(
            viewWillAppear: Just(()).eraseToAnyPublisher(),
            markerDidSelect: PassthroughSubject<Int, Never>().eraseToAnyPublisher(),
            eraseButtonDidTap: PassthroughSubject<Void, Never>().eraseToAnyPublisher(),
            pinnedHouseID: pinnedHouseIDSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.mapListData
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                let result = data.houses
                self.rootView.emptyView.isHidden = result.isEmpty ? false : true
                
                if !result.isEmpty {
                    self.updateSnapshot(with: result)
                }
            }
            .store(in: cancelBag)
        
        output.pinnedInfo
            .receive(on: RunLoop.main)
            .sink { [weak self] (houseID, isPinned) in
                guard let self = self else { return }
                
                if let index = self.viewModel.mapDataSubject.value?.houses.firstIndex(
                    where: { $0.houseID == houseID }
                ) {
                    let indexPath = IndexPath(item: index, section: 0)
                    if let cell = self.rootView.collectionView.cellForItem(at: indexPath) as?
                        HouseListCollectionViewCell {
                        cell.updateWishButton(isPinned: isPinned)
                    }
                }
                if isPinned == false {
                    Toast().show(message: "찜 목록에서 삭제되었어요", inset: 32, view: rootView)
                }
            }
            .store(in: cancelBag)
    }
    
    func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Int, House> {
        return UICollectionViewDiffableDataSource(
            collectionView: rootView.collectionView
        ) { collectionView, indexPath, model in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? HouseListCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.wishButton
                .controlEventPublisher(for: .touchUpInside)
                .sink {
                    self.pinnedHouseIDSubject.send(model.houseID)
                }
                .store(in: self.cancelBag)
            
            cell.dataBind(model)
            return cell
        }
    }
    
    func updateSnapshot(with data: [House]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, House>()
        snapshot.appendSections([0])
        snapshot.appendItems(data, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
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
