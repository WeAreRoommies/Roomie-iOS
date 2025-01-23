//
//  TourCheckViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/15/25.
//

import Foundation
import Combine

// TODO: bulider이용해서 roomId, houseId를 model로 보내주기
final class TourCheckViewModel {
    
    // MARK: - Property
    
    private(set) var selectedRoomInfo: SelectedRoomInfo
    
    private let roomIDSubject = PassthroughSubject<Int, Never>()
    private let houseIDSubject = PassthroughSubject<Int, Never>()
    
    // MARK: - Initializer
    
    init(selectedRoomInfo: SelectedRoomInfo) {
        self.selectedRoomInfo = selectedRoomInfo
    }
}

extension TourCheckViewModel: ViewModelType {
    struct Input {
        let roomIDSubject: AnyPublisher<Int, Never>
        let houseIDSubject: AnyPublisher<Int, Never>
    }
    
    struct Output {
        
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        
        return Output()
    }
}
