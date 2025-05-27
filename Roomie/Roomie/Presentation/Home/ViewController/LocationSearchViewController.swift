//
//  LocationSearchViewController.swift
//  Roomie
//
//  Created by MaengKim on 5/26/25.
//

import UIKit
import Combine

import CombineCocoa

protocol LocationSearchViewControllerDelegate: AnyObject {
    func didSelectLocation(location: String, lat: Double, lng: Double)
}

final class LocationSearchViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = LocationSearchView()
    
    private let viewModel: HomeViewModel
    
    private let cancelBag = CancelBag()
    
    private lazy var dataSource = createDiffableDataSource()
    
    weak var delegate: LocationSearchViewControllerDelegate?
    
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 40
    private let cellHeight: CGFloat = 118
    final let contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    private let searchTextFieldEnterSubject = PassthroughSubject<String, Never>()
    private let locationDidSelectSubject = PassthroughSubject<String, Never>()
    
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

        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .grayscale1
        
        setRegister()
        bindViewModel()
        updateEmptyView(isEmpty: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Functions
    
    override func setDelegate() {
        rootView.collectionView.delegate = self
    }
    
    override func setAction() {
        hideKeyboardWhenDidTap()
        
        rootView.searchTextField.becomeFirstResponder()
        
        rootView.searchTextField
            .controlEventPublisher(for: .editingDidEndOnExit)
            .sink { [weak self] in
                guard let self = self else { return }
                self.searchTextFieldEnterSubject.send(self.rootView.searchTextField.text ?? "")
            }
            .store(in: cancelBag)
        
        rootView.searchTextField
            .controlEventPublisher(for: .editingChanged)
            .sink { [weak self] in
                guard let self = self else { return }
                let keyword = self.rootView.searchTextField.text ?? ""
                if keyword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.updateSnapshot(with: [])
                    self.updateEmptyView(isEmpty: true)
                }
            }
            .store(in: cancelBag)
    }
}

private extension LocationSearchViewController {
    func setRegister() {
        rootView.collectionView.register(
            MapSearchCollectionViewCell.self,
            forCellWithReuseIdentifier: MapSearchCollectionViewCell.reuseIdentifier
        )
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input(
            viewWillAppear: Empty().eraseToAnyPublisher(),
            pinnedHouseIDSubject: Empty().eraseToAnyPublisher(),
            searchTextFieldEnterSubject: searchTextFieldEnterSubject.eraseToAnyPublisher(),
            locationDidSelectSubject: locationDidSelectSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.locationSearchData
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                let result = data.locations
                self.updateSnapshot(with: result)
                self.updateEmptyView(isEmpty: result.isEmpty)
            }
            .store(in: cancelBag)
    }
    
    func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Int, Location> {
        return UICollectionViewDiffableDataSource(
            collectionView: rootView.collectionView
        ) { collectionView, indexPath, model in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MapSearchCollectionViewCell.reuseIdentifier, for: indexPath
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
    
    func updateEmptyView(isEmpty: Bool) {
        rootView.emptyView.isHidden = !isEmpty
        rootView.collectionView.isHidden = isEmpty
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LocationSearchViewController: UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let selectedLocation = dataSource.itemIdentifier(for: indexPath)
        if let location = selectedLocation {
            self.locationDidSelectSubject.send(location.address)
        }
        
        if let selectedLocation = dataSource.itemIdentifier(for: indexPath) {
            delegate?.didSelectLocation(
                location: selectedLocation.location,
                lat: selectedLocation.x,
                lng: selectedLocation.y
            )
        }
        self.navigationController?.popViewController(animated: true)
    }
}
