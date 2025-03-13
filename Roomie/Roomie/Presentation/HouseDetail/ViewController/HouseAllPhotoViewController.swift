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
    
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    
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
        viewDidLoadSubject.send(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar(with: navigationBarTitle, isBorderHidden: false)
    }
}

// MARK: - Functions

private extension HouseAllPhotoViewController {
    func bindViewModel() {
        let input = HouseAllPhotoViewModel.Input(
            viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher()
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
                rootView.facilityImageScrollView
                    .setImages(urlStrings: houseDetailImagesData.images.facilityImageURLs)
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
