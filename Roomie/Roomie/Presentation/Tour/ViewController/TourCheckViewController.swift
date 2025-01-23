//
//  TourCheckViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/11/25.
//

import UIKit
import Combine

import CombineCocoa

final class TourCheckViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = TourCheckView()
    
    private let viewModel: TourCheckViewModel
    
    private let nextButtonSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(viewModel: TourCheckViewModel) {
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
        setTourCheckTitle()
    }
    
    override func setView() {
        setNavigationBar(with: "", isBorderHidden: true)
    }
    
    override func setAction() {
        rootView.nextButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                self.nextButtonSubject.send(())
            }
            .store(in: cancelBag)
    }
}

// MARK: - Functions

private extension TourCheckViewController {
    // TODO: 이전 뷰에서 roomID, houseID 받아와서 subject에 연결
    func bindViewModel() {
        let input = TourCheckViewModel.Input(
            nextButtonSubject: nextButtonSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.presentNextView
            .sink { [weak self] in
                guard let self else { return }
                let tourUserViewController = TourUserViewController(
                    viewModel: TourUserViewModel(
                        builder: TourRequestDTO.Builder.shared, roomID: viewModel.selectedRoomInfo.roomID
                    )
                )
                self.navigationController?.pushViewController(tourUserViewController, animated: true)
            }
            .store(in: cancelBag)
        
    }
    
    func setTourCheckTitle() {
        rootView.houseNameLabel.updateText(viewModel.selectedRoomInfo.houseName)
        rootView.roomNameLabel.updateText(viewModel.selectedRoomInfo.roomName)
    }
}

