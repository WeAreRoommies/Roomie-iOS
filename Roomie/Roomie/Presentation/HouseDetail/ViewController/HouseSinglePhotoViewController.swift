//
//  HouseSinglePhotoViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import UIKit
import Combine

import CombineCocoa

final class HouseSinglePhotoViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = HouseSinglePhotoView()
    
    private var navigationBarTitle: String = ""
    
    private let viewModel: HouseSinglePhotoViewModel
    
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    private var expandedIndex: Int
    
    // MARK: - Initializer
    
    init(title navigationBarTitle: String, index expandedIndex: Int, viewModel: HouseSinglePhotoViewModel) {
        self.navigationBarTitle = navigationBarTitle
        self.expandedIndex = expandedIndex
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
        viewDidLoadSubject.send(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar(with: navigationBarTitle, isBorderHidden: false)
    }
}

// MARK: - Functions

private extension HouseSinglePhotoViewController {
    func bindViewModel() {
        let input = HouseSinglePhotoViewModel.Input(
            viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.houseDetailRoomsData
            .receive(on: RunLoop.main)
            .sink { [weak self] houseDetailRoomsData in
                guard let self else { return }
                rootView.fetchRooms(houseDetailRoomsData.rooms, with: expandedIndex)
            }
            .store(in: cancelBag)
    }
}
