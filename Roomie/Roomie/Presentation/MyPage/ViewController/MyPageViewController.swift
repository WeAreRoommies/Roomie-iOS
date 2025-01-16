//
//  MyPageViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import UIKit

final class MyPageViewController: BaseViewController {
    
    // MARK: - UIComponent

    private let rootView = MyPageView()
    
    // MARK: - Property

    private let plusData = MyPageModel.myPagePlusData()
    private let serviceData = MyPageModel.myPageServiceData()
    
    // MARK: - LifeCycle

    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegister()
    }
    
    // MARK: - Functions

    override func setView() {
        setNavigationBar(with: "마이페이지")
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
}

extension MyPageViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if indexPath.row == 0 {
            let wishListController = WishListViewController(viewModel: WishListViewModel())
            self.navigationController?.pushViewController(wishListController, animated: true)
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
