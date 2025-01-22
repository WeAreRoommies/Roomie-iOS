//
//  MyPageViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import UIKit
import Combine

final class MyPageViewController: BaseViewController {
    
    // MARK: - UIComponent

    private let rootView = MyPageView()
    
    private let viewModel: MyPageViewModel
    
    private let cancelBag = CancelBag()
    
    // MARK: - Property
    
    private let plusData = MyPageModel.myPagePlusData()
    private let serviceData = MyPageModel.myPageServiceData()
    
    private let viewWillAppearSubject = CurrentValueSubject<Void, Never>(())
    
    // MARK: - Initializer

    init(viewModel: MyPageViewModel) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewWillAppearSubject.send(())
    }
    
    // MARK: - Functions

    override func setView() {
        setNavigationBar(with: "마이페이지", isBackButtonHidden: true)
    }
    
    override func setDelegate() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
    }
}

private extension MyPageViewController {
    func setRegister() {
        rootView.collectionView.register(
            MyPageCollectionViewCell.self,
            forCellWithReuseIdentifier: MyPageCollectionViewCell.reuseIdentifier
        )
        
        rootView.collectionView.register(
            MyPagePlusHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MyPagePlusHeaderView.reuseIdentifier
        )
        
        rootView.collectionView.register(
            MyPageServiceHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MyPageServiceHeaderView.reuseIdentifier
        )
    }
    
    func bindViewModel() {
        let input = MyPageViewModel.Input(
            viewWillAppearSubject: viewWillAppearSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.userName
            .receive(on: RunLoop.main)
            .sink { [weak self] name in
                guard let self = self else { return }
                if let header = self.rootView.collectionView.supplementaryView(
                    forElementKind: UICollectionView.elementKindSectionHeader,
                    at: IndexPath(item: 0, section: 0)
                ) as? MyPagePlusHeaderView {
                    header.dataBind(nickname: name)
                }
            }
            .store(in: cancelBag)
    }
}

extension MyPageViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let wishListViewController = WishListViewController(viewModel: WishListViewModel())
                wishListViewController.hidesBottomBarWhenPushed = true
                self.navigationController?
                    .pushViewController(wishListViewController, animated: true)
            }
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MyPageViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0:
            return plusData.count
        default:
            return serviceData.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyPageCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? MyPageCollectionViewCell else { return UICollectionViewCell() }
            cell.dataBind(plusData[indexPath.item])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyPageCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? MyPageCollectionViewCell else { return UICollectionViewCell() }
            cell.dataBind(serviceData[indexPath.item])
            return cell
        default:
            return MyPageCollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: MyPagePlusHeaderView.reuseIdentifier,
                    for: indexPath
                ) as? MyPagePlusHeaderView else { return UICollectionReusableView() }
                header.configureHeader(title: "루미 더보기")
                return header
            case 1:
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: MyPageServiceHeaderView.reuseIdentifier,
                    for: indexPath
                ) as? MyPageServiceHeaderView else { return UICollectionReusableView() }
                header.configureHeader(title: "루미 서비스 정보")
                return header
            default:
                break
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: 160)
        case 1:
            return CGSize(width: UIScreen.main.bounds.width, height: 56)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
