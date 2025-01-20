//
//  MapSearchViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa

final class MapSearchViewController: BaseViewController {
    
    // MARK: - Property

    private let rootView = MapSearchView()
    
    private let viewModel: MapSearchViewModel
    
    private let cancelBag = CancelBag()
    
    private lazy var dataSource = createDiffableDataSource()
    
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 40
    final let cellHeight: CGFloat = 118
    final let contentInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
    
    private let searchTextFieldEnterSubject = PassthroughSubject<String, Never>()
    
    // MARK: - Initializer

    init(viewModel: MapSearchViewModel) {
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
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Functions
    
    override func setDelegate() {
        rootView.collectionView.delegate = self
    }
    
    override func setAction() {
        hideKeyboardWhenDidTap()
        
        rootView.searchTextField.becomeFirstResponder()
        
        rootView.backButton
            .tapPublisher
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: cancelBag)
        
        rootView.searchTextField
            .controlEventPublisher(for: .editingDidEndOnExit)
            .sink { [weak self] in
                guard let self = self else { return }
                self.searchTextFieldEnterSubject.send(self.rootView.searchTextField.text ?? "")
            }
            .store(in: cancelBag)
    }
}

private extension MapSearchViewController {
    func setRegister() {
        rootView.collectionView.register(
            MapSearchCollectionViewCell.self,
            forCellWithReuseIdentifier: MapSearchCollectionViewCell.reuseIdentifier
        )
    }
    
    func bindViewModel() {
        let input = MapSearchViewModel.Input(
            searchTextFieldEnterSubject: searchTextFieldEnterSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.mapSearchData
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                let result = data.locations
                self.rootView.emptyView.isHidden = result.isEmpty ? false : true
                
                if !result.isEmpty {
                    self.updateSnapshot(with: result)
                }
            }
            .store(in: cancelBag)
    }
    
    func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Int, Location> {
        return UICollectionViewDiffableDataSource(
            collectionView: rootView.collectionView
        ) { collectionView, indexPath, model in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MapSearchCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? MapSearchCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.dataBind(model)
            return cell
        }
    }
    
    func updateSnapshot(with data: [Location]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Location>()
        snapshot.appendSections([0])
        snapshot.appendItems(data, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MapSearchViewController: UICollectionViewDelegateFlowLayout {
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
