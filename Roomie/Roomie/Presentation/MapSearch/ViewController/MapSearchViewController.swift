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
    
    private var mapSearchData: [MapSearchModel] = []
    
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
        rootView.collectionView.dataSource = self
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
            .sink { [weak self] data in
                guard let self = self else { return }
                self.mapSearchData = data
                self.rootView.emptyView.isHidden = data.isEmpty ? false : true
                
                if !data.isEmpty {
                    self.rootView.collectionView.reloadData()
                }
            }
            .store(in: cancelBag)
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

// MARK: - UICollectionViewDataSource

extension MapSearchViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return mapSearchData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MapSearchCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? MapSearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = mapSearchData[indexPath.row]
        cell.dataBind(data)
        
        return cell
    }
}
