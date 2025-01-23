//
//  HouseAllPhotoViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import UIKit
import Combine

import CombineCocoa
import Kingfisher

final class HouseAllPhotoViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = HouseAllPhotoView()
    
    private var navigationBarTitle: String = ""
    
    private let viewModel: HouseAllPhotoViewModel
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(title navigationBarTitle: String, viewModel: HouseAllPhotoViewModel) {
        self.navigationBarTitle = navigationBarTitle
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearSubject.send(())
//        rootView.fetchRooms(RoomDetail.mockData())
    }
    
    override func setView() {
        setNavigationBar(with: navigationBarTitle)
    }
}

// MARK: - Functions

private extension HouseAllPhotoViewController {
    func bindViewModel() {
        let input = HouseAllPhotoViewModel.Input(
            viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.houseDetailImagesData
            .receive(on: RunLoop.main)
            .sink { [weak self] houseDetailImagesData in
                guard let self else { return }
                if let mainImageURL = URL(string: houseDetailImagesData.images.mainImageURL) {
                    self.rootView.mainImageView.kf.setImage(with: mainImageURL)
                }
                rootView.mainDescriptionLabel
                    .updateText(houseDetailImagesData.images.mainImageDescription)
                if let facilityImageURL = URL(string: houseDetailImagesData.images.facilityImageURLs[0]) {
                    self.rootView.facilityImageView.kf.setImage(with: facilityImageURL)
                }
                rootView.facilityDescriptionLabel
                    .updateText(houseDetailImagesData.images.facilityImageDescription)
                if let floorImageURL = URL(string: houseDetailImagesData.images.floorImageURL) {
                    self.rootView.floorImageView.kf.setImage(with: floorImageURL)
                }
            }
            .store(in: cancelBag)
        
        output.houseDetailRoomsData
            .receive(on: RunLoop.main)
            .sink { [weak self] houseDetailRoomsData in
                guard let self else { return }
                rootView.fetchRooms(houseDetailRoomsData.rooms)
            }
            .store(in: cancelBag)
    }
}
