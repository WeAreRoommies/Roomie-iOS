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
    
    private let houseDetailData = HouseDetailModel.mockData()
    
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
    func setRegister() { // 아래로 빼
        rootView.collectionView
            .register(
                HousePhotoCell.self,
                forCellWithReuseIdentifier: HousePhotoCell.reuseIdentifier
            )
        rootView.collectionView
            .register(
                HouseInfoCell.self,
                forCellWithReuseIdentifier: HouseInfoCell.reuseIdentifier
            )
        rootView.collectionView
            .register(
                RoomMoodCell.self,
                forCellWithReuseIdentifier: RoomMoodCell.reuseIdentifier
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
                // TODO: combine으로 collecionView 바인딩 해주는 거 찾아보기
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
        default:
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch HouseDetailSection(rawValue: indexPath.section) {
        case .housePhoto:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HousePhotoCell.reuseIdentifier,
                for: indexPath
            )
            // TODO: housePhotoCell 데이터 바인딩
            return cell
        case .houseInfo:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HouseInfoCell.reuseIdentifier,
                for: indexPath
            )
            // TODO: houseInfoCell 데이터 바인딩
            return cell
        case .roomMood:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RoomMoodCell.reuseIdentifier,
                for: indexPath
            )
            // TODO: roomMoodCell 데이터 바인딩
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
        default:
            return UICollectionReusableView() // 빈 헤더 반환
        }
    }
}
