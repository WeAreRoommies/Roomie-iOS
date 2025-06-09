//
//  ViewController.swift
//  Roomie
//
//  Created by MaengKim on 1/7/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

private enum homeNavigationBarStatus {
    case top
    case scrolled
}

final class HomeViewController: BaseViewController {
    
    // MARK: - Property
    
    private let viewModel: HomeViewModel
    
    private let cancelBag = CancelBag()
    
    private let rootView = HomeView()
    
    private lazy var dataSource = createDiffableDataSource()
    
    private let locationButton = UIButton(type: .system)
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let pinnedHouseIDSubject = PassthroughSubject<Int, Never>()
        
    final let cellHeight: CGFloat = 112
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let contentInterSpacing: CGFloat = 4
    
    private var homeNavigationBarStatus: homeNavigationBarStatus = .scrolled {
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
        super.viewWillAppear(animated)
        
        updateSeletedCell()
        setHomeNavigationBarStatus()
        viewWillAppearSubject.send()
    }
    
    // MARK: - Functions
    
    override func setAction() {
        locationButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.presentLocationSearchSheet()
            }
            .store(in: cancelBag)
        
        rootView.updateButton.updateButton
            .tapPublisher
            .sink {
                let webViewController = APPLELOVERCLUBViewController()
                self.navigationController?.pushViewController(webViewController, animated: true)
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
            viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher(),
            pinnedHouseIDSubject: pinnedHouseIDSubject.eraseToAnyPublisher(),
            searchTextFieldEnterSubject: Empty().eraseToAnyPublisher(),
            locationDidSelectSubject: Empty().eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.userInfo
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self else { return }
                self.rootView.nameLabel.text = data.nickname
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
        
        output.pinnedInfo
            .receive(on: RunLoop.main)
            .sink { [weak self] (houseID, isPinned) in
                guard let self = self else { return }

                if let index = self.viewModel.homeDataSubject.value?.recentlyViewedHouses.firstIndex(
                    where: { $0.houseID == houseID }
                ) {
                    let indexPath = IndexPath(item: index, section: 0)
                    if let cell = self.rootView.houseListCollectionView.cellForItem(at: indexPath) as?
                        HouseListCollectionViewCell {
                        cell.updateWishButton(isPinned: isPinned)
                    }
                }
                if isPinned == false {
                    Toast().show(message: "찜 목록에서 삭제되었어요", inset: 8, view: rootView)
                }
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
            cell.wishButton
                .controlEventPublisher(for: .touchUpInside)
                .sink {
                    self.pinnedHouseIDSubject.send(model.houseID)
                }
                .store(in: self.cancelBag)
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
        case .top:
            barAppearance.backgroundColor = .grayscale1
        case .scrolled:
            barAppearance.backgroundColor = .primaryLight4
        }
        
        barAppearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    func setHomeNavigationBar(locaton location: String) {
        title = nil
        navigationItem.leftBarButtonItem = nil
        
        let locationLabel = UILabel()
        let likedButton = UIBarButtonItem(
            image: .icnHeartLine24,
            style: .plain,
            target: self,
            action: #selector(wishLishButtonDidTap)
        )
        let dropDownImageView = UIImageView(image: .icnArrowDownFilled16)
        let locationButtonStack = UIStackView()
        
        dropDownImageView.snp.makeConstraints {
            $0.size.equalTo(16)
        }
        
        locationButtonStack.addArrangedSubviews(locationLabel, dropDownImageView)
        locationButtonStack.do {
            $0.axis = .horizontal
                    $0.spacing = 8
                    $0.alignment = .center
                    $0.isUserInteractionEnabled = false
        }
        
        locationButton.addSubview(locationButtonStack)
        locationButtonStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        locationButton.sizeToFit()
        locationButton.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.width.equalTo(Screen.width(66))
        }
        
        let locationBarButton = UIBarButtonItem(customView: locationButton)
        
        likedButton.tintColor = .grayscale10
        barAppearance.backgroundColor = .primaryLight4
        locationLabel.do {
            $0.setText(location, style: .title2, color: .grayscale10)
        }
        
        navigationItem.rightBarButtonItem = likedButton
        navigationItem.leftBarButtonItem = locationBarButton
        
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
    
    func presentLocationSearchSheet() {
        let locationViewController = LocationSearchSheetViewController(
            viewModel: HomeViewModel(service: HomeService())
        )
        locationViewController.delegate = self
        if let sheet = locationViewController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        locationViewController.isModalInPresentation = false
        self.present(locationViewController, animated: true)
    }
    
    @objc
    func wishLishButtonDidTap() {
        let wishListViewController = WishListViewController(
            viewModel: WishListViewModel(service: WishListService())
        )
        wishListViewController.hidesBottomBarWhenPushed = true
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
        guard let houseID = viewModel.homeDataSubject.value?.recentlyViewedHouses[indexPath.item].houseID else { return }
        let houseDetailViewController = HouseDetailViewController(
            viewModel: HouseDetailViewModel(houseID: houseID, service: HousesService())
        )
        houseDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
}

// MARK: - ScrollView Delegate

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > -90 {
            homeNavigationBarStatus = .top
        } else {
            homeNavigationBarStatus = .scrolled
        }
        
        let maxOffsetY = rootView.scrollView.contentSize.height - rootView.scrollView.bounds.height

        rootView.backgroundColor = rootView.scrollView.contentOffset.y
        >= maxOffsetY ? .grayscale1 : .primaryLight4
    }
}

extension HomeViewController: LocationSearchSheetViewControllerDelegate {
    func didSelectLocation(location: String, lat: Double, lng: Double) {
        // TODO: - 서버 작업 완료 시 추후 연결
    }
}
