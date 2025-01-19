//
//  ViewController.swift
//  Roomie
//
//  Created by MaengKim on 1/7/25.
//

import UIKit
import Combine

import SnapKit
import Then
import CombineCocoa

// TODO: user name 연결

final class HomeViewController: BaseViewController {
    
    // MARK: - Property
    
    private let viewModel: HomeViewModel
    
    private let cancelBag = CancelBag()
    
    private let rootView = HomeView()
        
    final let cellHeight: CGFloat = 112
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let contentInterSpacing: CGFloat = 4
    
    private var recentlyRooms: [RecentlyRoom] = RecentlyRoom.mockHomeData()
    private var userInfo: UserInfo = UserInfo.mockUserData()
    
    // MARK: - Initializer
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        rootView.nameLabel.text = userInfo.name
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
        updateEmtpyView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateEmtpyView()
        rootView.layoutIfNeeded()
        rootView.gradientView.setGradient(for: .home)
    }
    
    override func setView() {
        setHomeNavigationBar()
    }
    
    // MARK: - Functions
    
    override func setAction() {
        rootView.updateButton.updateButton
            .tapPublisher
            .sink { [weak self] in
                // TODO: 추후 재 화면연결 필요
                let houseDetailViewController = HouseDetailViewController(
                    viewModel: HouseDetailViewModel()
                )
                houseDetailViewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(houseDetailViewController, animated: true)
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
            HouseListCollectionViewCell.self,
            forCellWithReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier
        )
    }
}

// MARK: - Functions

private extension HomeViewController {
    func updateCollectionViewHeight() -> CGFloat{
        let numberOfItems = recentlyRooms.count
        let cellsHeight = CGFloat(numberOfItems) * cellHeight
        let totalSpacing = CGFloat(numberOfItems - 1) * contentInterSpacing
        let totalHeight = cellsHeight + totalSpacing

        return totalHeight
    }
    
    func updateEmtpyView() {
        let isEmpty = recentlyRooms.isEmpty
        rootView.emptyView.isHidden = !isEmpty
        rootView.roomListCollectionView.isHidden = isEmpty
        
        if !isEmpty {
            let totalHeight = updateCollectionViewHeight()
            rootView.roomListCollectionView.snp.updateConstraints {
                $0.height.equalTo(max(totalHeight, 0))
            }
        } else {
            rootView.roomListCollectionView.snp.updateConstraints {
                $0.height.equalTo(226)
            }
        }
    }
    
    func setHomeNavigationBar() {
        title = nil
        navigationItem.leftBarButtonItem = nil
        
        let barAppearance = UINavigationBarAppearance()
        let locationLabel = UILabel()
        let likedButton = UIBarButtonItem(
            image: .icnHeartLine24,
            style: .plain,
            target: self,
            action: #selector(wishLishButtonDidTap)
        )
        let dropDownImageView = UIImageView(image: .icnArrowDownFilled16)
        
        let locationItem = UIBarButtonItem(customView: locationLabel)
        let dropDownItem = UIBarButtonItem(customView: dropDownImageView)
        likedButton.tintColor = .grayscale10
        barAppearance.backgroundColor = .primaryLight4
        barAppearance.shadowColor = nil
        locationLabel.do {
            $0.setText(userInfo.location, style: .title2, color: .grayscale10)
        }
        
        navigationItem.rightBarButtonItem = likedButton
        navigationItem.leftBarButtonItems = [locationItem, dropDownItem]
        
        
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    @objc
    func wishLishButtonDidTap() {
        let wishListViewController = WishListViewController(viewModel: WishListViewModel())
        self.navigationController?.pushViewController(wishListViewController, animated: true)
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
            withReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? HouseListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = recentlyRooms[indexPath.row]
        cell.dataBind(data)
        
        return cell
    }
}
