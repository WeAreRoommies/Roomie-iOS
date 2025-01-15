//
//  TourDateViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/15/25.
//

import Foundation
import Combine

// TODO: bulider이용해서 date, message를 model로 보내주기
final class TourDateViewModel {
    
    // MARK: - Property
    
    private let dateSubject = PassthroughSubject<String, Never>()
    private let messageSubject = CurrentValueSubject<String, Never>("")
    
}

extension TourDateViewModel: ViewModelType {
    struct Input {
        let dateSubject: AnyPublisher<String, Never>
        let messageSubject: AnyPublisher<String, Never>
    }
    
    struct Output {
        let isNextButtonEnabled: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.dateSubject
            .sink { [weak self] date in
                self?.dateSubject.send(date)
            }
            .store(in: cancelBag)
        
        input.messageSubject
            .sink { [weak self] message in
                self?.messageSubject.send(message)
            }
            .store(in: cancelBag)
        
        let isNextButtonEnabled = dateSubject
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
        
        return Output(isNextButtonEnabled: isNextButtonEnabled)
    }
}
