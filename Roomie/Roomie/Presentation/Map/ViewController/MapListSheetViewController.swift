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
            RoomListCollectionViewCell.self,
            forCellWithReuseIdentifier: RoomListCollectionViewCell.reuseIdentifier
        )
    }
    
    func bindViewModel() {
        let input = MapViewModel.Input(
            viewWillAppear: Just(()).eraseToAnyPublisher(),
            markerDidSelect: PassthroughSubject<Int, Never>().eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.mapListData
            .sink { [weak self] data in
                guard let self = self else { return }
                self.rootView.emptyView.isHidden = data.isEmpty ? false : true
                
                if !data.isEmpty {
                    self.updateSnapshot(with: data)
                }
            }
            .store(in: cancelBag)
    }
    
    func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Int, MapModel> {
        return UICollectionViewDiffableDataSource(
            collectionView: rootView.collectionView
        ) { collectionView, indexPath, model in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RoomListCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? RoomListCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.dataBind(model)
            return cell
        }
    }
    
    func updateSnapshot(with data: [MapModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MapModel>()
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
