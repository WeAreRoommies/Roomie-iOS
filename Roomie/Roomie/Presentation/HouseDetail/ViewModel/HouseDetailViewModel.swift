//
//  HouseDetailViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import Foundation
import Combine

final class HouseDetailViewModel {
    // MARK: - Property
    
    private let roomIDSubject = PassthroughSubject<Int, Never>()
    
}

extension HouseDetailViewModel: ViewModelType {
    struct Input {
        let roomIDSubject: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let isTourApplyButtonEnabled: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.roomIDSubject
            .sink { [weak self] roomID in
                guard let self else { return }
                self.roomIDSubject.send(roomID)
            }
            .store(in: cancelBag)
        
        let isTourApplyButtonEnabled = self.roomIDSubject
            .map { _ in true }
            .eraseToAnyPublisher()
        
        return Output(isTourApplyButtonEnabled: isTourApplyButtonEnabled)
    }
}
