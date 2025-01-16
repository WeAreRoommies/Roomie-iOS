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
    
    final let cellHeight: CGFloat = 112
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let contentInterSpacing: CGFloat = 4
    
    private var recentlyRooms: [RecentlyRoom] = RecentlyRoom.mockHomeData()
    
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
        
        setDelegate()
        setRegister()
        updateCollectionViewHeight()
    }
    
    // MARK: - Functions
    
    override func setAction() {
        rootView.updateButton.updateButton
            .tapPublisher
            .sink {
                // TODO: 업데이트 연결
            }
            .store(in: cancelBag)
        
        rootView.calmCardView.moodButton
            .tapPublisher
            .sink {
                let calmMoodListViewController = MoodListViewController(
                    viewModel: MoodListViewModel(),
                    moodType: .calm
                )
                calmMoodListViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(calmMoodListViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.livelyCardView.moodButton
            .tapPublisher
            .sink {
                let livelyMoodListViewController = MoodListViewController(
                    viewModel: MoodListViewModel(),
                    moodType: .lively
                )
                livelyMoodListViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(livelyMoodListViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.neatCardView.moodButton
            .tapPublisher
            .sink {
                let neatMoodListViewController = MoodListViewController(
                    viewModel: MoodListViewModel(),
                    moodType: .neat
                )
                neatMoodListViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(neatMoodListViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.nextMapView.updateButton
            .tapPublisher
            .sink {
                self.tabBarController?.selectedIndex = 1
            }
            .store(in: cancelBag)
    }
    
    override func setDelegate() {
        rootView.roomListCollectionView.delegate = self
        rootView.roomListCollectionView.dataSource = self
    }
    
    private func setRegister() {
        rootView.roomListCollectionView.register(
            RoomListCollectionViewCell.self,
            forCellWithReuseIdentifier: RoomListCollectionViewCell.reuseIdentifier
        )
    }
    
    private func updateCollectionViewHeight() {
        let numberOfItems = recentlyRooms.count
        let cellsHeight = CGFloat(numberOfItems) * cellHeight
        let totalSpacing = CGFloat(numberOfItems - 1) * contentInterSpacing
        let totalHeight = cellsHeight + totalSpacing
        
        rootView.roomListTableViewHeightConstraint?.update(offset: totalHeight)
        rootView.layoutIfNeeded()
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
        minimumLineSpacingForSectionAt section: Int
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
        return recentlyRooms.count
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
        
        let data = recentlyRooms[indexPath.row]
        cell.dataBind(data)
        
        return cell
    }
}
