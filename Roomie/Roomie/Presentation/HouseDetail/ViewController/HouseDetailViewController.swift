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
    
    private let viewModel: HouseDetailViewModel
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(viewModel: HouseDetailViewModel) {
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
        super.viewWillAppear(animated)
        
        viewWillAppearSubject.send(())
    }
    
    override func setDelegate() {
        rootView.collectionView.dataSource = self
    }
}

// MARK: - Functions

private extension HouseDetailViewController {
    func setRegister() {
        rootView.collectionView
            .register(
                HousePhotoCollectionViewCell.self,
                forCellWithReuseIdentifier: HousePhotoCollectionViewCell.reuseIdentifier
            )
        rootView.collectionView
            .register(
                HouseInfoCollectionViewCell.self,
                forCellWithReuseIdentifier: HouseInfoCollectionViewCell.reuseIdentifier
            )
        rootView.collectionView
            .register(
                RoomMoodCollectionViewCell.self,
                forCellWithReuseIdentifier: RoomMoodCollectionViewCell.reuseIdentifier
            )
        rootView.collectionView
            .register(
                RoomStatusCollectionViewCell.self,
                forCellWithReuseIdentifier: RoomStatusCollectionViewCell.reuseIdentifier
            )
        
        rootView.collectionView
            .register(
                HouseDetailHeaderView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HouseDetailHeaderView.reuseIdentifier
            )
    }
    
    func bindViewModel() {
        let input = HouseDetailViewModel.Input(
            viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.houseInfo
            .sink { data in
                
                // TODO: ViewModel -> CollectionView dataBinding
                
                dump(data)
            }
            .store(in: cancelBag)
    }
}

// MARK: - UICollectionViewDataSource

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
        case .roomMood:
            return 1
        case .roomStatus:
            return 3 // TODO: Data Binding 필요
        default:
            return 0
        }
    }
    
    // TODO: 각 cell 마다 데이터 바인딩 필요
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch HouseDetailSection(rawValue: indexPath.section) {
        case .housePhoto:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HousePhotoCollectionViewCell.reuseIdentifier,
                for: indexPath
            )
            
            return cell
        case .houseInfo:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HouseInfoCollectionViewCell.reuseIdentifier,
                for: indexPath
            )
            
            return cell
        case .roomMood:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RoomMoodCollectionViewCell.reuseIdentifier,
                for: indexPath
            )
            
            return cell
        case .roomStatus:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RoomStatusCollectionViewCell.reuseIdentifier,
                for: indexPath
            )
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch HouseDetailSection(rawValue: indexPath.section) {
        case .roomMood:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HouseDetailHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HouseDetailHeaderView else { return UICollectionReusableView() }
            return header
            
        case .roomStatus:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HouseDetailHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HouseDetailHeaderView else { return UICollectionReusableView() }
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
}
