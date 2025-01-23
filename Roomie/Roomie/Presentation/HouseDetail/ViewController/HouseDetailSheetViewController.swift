//
//  HouseDetailSheetViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/21/25.
//

import UIKit
import Combine

final class HouseDetailSheetViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = HouseDetailSheetView()
    
    private let viewModel: HouseDetailViewModel
    
    private let buttonIndexSubject = PassthroughSubject<Int, Never>()
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(viewModel: HouseDetailViewModel) {
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
    }
    
    override func setAction() {
        for button in rootView.buttons {
            button.roomButton.tapPublisher
                .map { button.tag }
                .sink { [weak self] index in
                    guard let self else { return }
                    
                    // TODO: 선택된 index로 rooms[index].roomID ViewModel에 넘기기
                    self.updateRadioButton(selectedIndex: index)
                    self.buttonIndexSubject.send(index)
                }
                .store(in: cancelBag)
        }
    }
}

// MARK: - Functions

private extension HouseDetailSheetViewController {
    func bindViewModel() {
        let input = HouseDetailViewModel.Input(
            houseDetailViewWillAppear: Just(()).eraseToAnyPublisher(),
            bottomSheetViewWillAppear: viewWillAppearSubject.eraseToAnyPublisher(),
            buttonIndexSubject: buttonIndexSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(
            from: input,
            cancelBag: cancelBag
        )
        
        output.isTourApplyButtonEnabled
            .sink { [weak self] isEnabled in
                guard let self else { return }
                rootView.tourApplyButton.isEnabled = isEnabled
            }
            .store(in: cancelBag)
        
        output.roomButtonInfos
            .sink { [weak self] roomButtonInfos in
                guard let self else { return }
                self.rootView.dataBind(roomButtonInfos)
            }
            .store(in: cancelBag)
        
        output.selectedRoomID
            .sink { [weak self] selectedRoomID in
                guard let self else { return }
                // TODO: 선택된 방의 RoomID를 주입시켜주면서 화면 연결
                print(selectedRoomID)
            }
            .store(in: cancelBag)
    }
    
    func updateRadioButton(selectedIndex: Int) {
        for button in rootView.buttons {
            if button.tag != selectedIndex {
                button.isSelected = false
            }
        }
    }
}
