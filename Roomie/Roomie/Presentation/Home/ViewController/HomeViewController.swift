//
//  ViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit
import Combine

import SnapKit
import Then
import CombineCocoa

final class HomeViewController: BaseViewController {
    
    // MARK: - Property
    
    private let viewModel: HomeViewModel
    
    private let cancelBag = CancelBag()
    
    private let rootView = HomeView()
    
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let cellHeight: CGFloat = 112
    final let contentInterSpacing: CGFloat = 4
    
    // MARK: - Initializer
    
    init(viewModel: HomeViewModel) {
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
        
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        
        rootView.collectionView.register(
            RoomListCollectionCell.self,
            forCellWithReuseIdentifier: RoomListCollectionCell.reuseIdentifier
        )
    }
    
    // MARK: - Functions
    
    override func setAction() {
        rootView.updateButton.updateButton
            .tapPublisher
            .sink {
                // TODO: 화면 전환하기
            }
            .store(in: cancelBag)
        
        rootView.calmCardView.moodButton
            .tapPublisher
            .sink {
                // TODO: 화면 전환하기
            }
            .store(in: cancelBag)
        
        rootView.livelyCardView.moodButton
            .tapPublisher
            .sink {
                // TODO: 화면 전환하기
            }
            .store(in: cancelBag)
        
        rootView.neatCardView.moodButton
            .tapPublisher
            .sink {
                // TODO: 화면 전환하기
            }
            .store(in: cancelBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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
        minimumLineSpacingForsectionAt section: Int
    ) -> CGFloat {
        return contentInterSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        // TODO: 상세매물 페이지와 연결
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return HomeModel.mockHomeData().count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(
            withReuseIdentifier: RoomListCollectionCell.reuseIdentifier,
            for: indexPath
        ) as? RoomListCollectionCell else {
            return UICollectionViewCell()
        }
        
        let data = HomeModel.mockHomeData()[indexPath.row]
        
        item.dataBind(
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
        return item
    }
}
