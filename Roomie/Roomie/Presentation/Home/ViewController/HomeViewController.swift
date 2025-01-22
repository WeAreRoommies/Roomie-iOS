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

private enum homeNavigationBarStatus {
    case white
    case purple
}

final class HomeViewController: BaseViewController {
    
    // MARK: - Property
    
    private let viewModel: HomeViewModel
    
    private let cancelBag = CancelBag()
    
    private let rootView = HomeView()
    
    private lazy var dataSource = createDiffableDataSource()
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
        
    final let cellHeight: CGFloat = 112
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let contentInterSpacing: CGFloat = 4
    
    private var homeNavigationBarStatus: homeNavigationBarStatus = .purple {
        didSet {
            setHomeNavigationBarStatus()
        }
    }
    private let barAppearance = UINavigationBarAppearance()

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
        
        bindViewModel()
        setRegister()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootView.houseListCollectionView.layoutIfNeeded()
        rootView.gradientView.setGradient(for: .home)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateSeletedCell()
        setHomeNavigationBarStatus()
        viewWillAppearSubject.send()
    }
    
    // MARK: - Functions
    
    override func setAction() {
        rootView.updateButton.updateButton
            .tapPublisher
            .sink { [weak self] in
                // TODO: 추후 재 화면연결 필요
                let houseDetailViewController = HouseDetailViewController(viewModel: HouseDetailViewModel(service: HousesService()))
                houseDetailViewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(houseDetailViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.calmCardView.moodButton
            .tapPublisher
            .sink {
                let calmMoodListViewController = MoodListViewController(
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
        rootView.houseListCollectionView.delegate = self
        rootView.scrollView.delegate = self
    }
}

// MARK: - Functions

private extension HomeViewController {
    func setRegister() {
        rootView.houseListCollectionView.register(
            HouseListCollectionViewCell.self,
            forCellWithReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier
        )
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input(
            viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.userInfo
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self else { return }
                self.rootView.nameLabel.text = data.name
                self.setHomeNavigationBar(locaton: data.location)
            }
            .store(in: cancelBag)
        
        output.houseList
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self else { return }
                if !data.isEmpty {
                    self.updateSnapshot(with: data)
                }
            }
            .store(in: cancelBag)
        
        output.houseCount
            .receive(on: RunLoop.main)
            .sink { [weak self] data in guard let self else { return }
                self.updateCollectionViewHeight(count: data)
                self.updateEmtpyView(isEmpty: data == 0)
            }
            .store(in: cancelBag)
    }
    
    func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Int, HomeHouse> {
        return UICollectionViewDiffableDataSource(collectionView: rootView.houseListCollectionView) {
            collectionView, indexPath, model in guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HouseListCollectionViewCell.reuseIdentifier,
                for: indexPath) as? HouseListCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.dataBind(model)
            return cell
        }
    }
    
    func updateSnapshot(with data: [HomeHouse]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeHouse>()
        snapshot.appendSections([0])
        snapshot.appendItems(data, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func updateCollectionViewHeight(count: Int) {
        let cellsHeight = CGFloat(count) * cellHeight
        let totalSpacing = CGFloat(count - 1) * contentInterSpacing
        let totalHeight = cellsHeight + totalSpacing
        
        rootView.houseListCollectionView.snp.updateConstraints{
            $0.height.equalTo(max(totalHeight, 0))
        }
    }
    
    func updateEmtpyView(isEmpty: Bool) {
        rootView.emptyView.isHidden = !isEmpty
        rootView.houseListCollectionView.isHidden = isEmpty
    }
    
    func setHomeNavigationBarStatus() {
        switch homeNavigationBarStatus {
        case .white:
            barAppearance.backgroundColor = .grayscale1
        case .purple:
            barAppearance.backgroundColor = .primaryLight4
        }
        
        barAppearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    func setHomeNavigationBar(locaton location:String) {
        title = nil
        navigationItem.leftBarButtonItem = nil
        
//        let barAppearance = UINavigationBarAppearance()
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
//        barAppearance.shadowColor = nil
        locationLabel.do {
            $0.setText(location, style: .title2, color: .grayscale10)
        }
        
        navigationItem.rightBarButtonItem = likedButton
        navigationItem.leftBarButtonItems = [locationItem, dropDownItem]
        
//        navigationController?.navigationBar.standardAppearance = barAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func updateSeletedCell() {
        for index in rootView.houseListCollectionView.indexPathsForVisibleItems {
            if let cell = rootView.houseListCollectionView.cellForItem(at: index) as?
                HouseListCollectionViewCell {
                cell.isSelected = false
            }
        }
    }
    
    @objc
    func wishLishButtonDidTap() {
        let wishListViewController = WishListViewController(
            viewModel: WishListViewModel(service: HousesService())
        )
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

// MARK: - ScrollView Delegate

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        if offsetY > -94 {
            homeNavigationBarStatus = .white
        } else {
            homeNavigationBarStatus = .purple
        }
        
        let maxOffsetY = rootView.scrollView.contentSize.height - rootView.scrollView.bounds.height

        rootView.backgroundColor = rootView.scrollView.contentOffset.y >= maxOffsetY ? .grayscale1 : .primaryLight4
    }
}

