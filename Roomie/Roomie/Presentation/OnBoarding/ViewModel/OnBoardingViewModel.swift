//
//  OnBoardingViewModel.swift
//  Roomie
//
//  Created by MaengKim on 5/20/25.
//

import Foundation
import Combine

final class OnBoardingViewModel {
    let currentPageSubject = CurrentValueSubject<OnBoardingType, Never>(.infoStep)
}

extension OnBoardingViewModel: ViewModelType {
    struct Input {
        let currentPageSubject: AnyPublisher<OnBoardingType, Never>
    }
    
    struct Output {
        let currentPage: AnyPublisher<OnBoardingType, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.currentPageSubject
            .sink { [weak self] type in
                self?.currentPageSubject.send(type)
            }
            .store(in: cancelBag)
        
        return Output(
            currentPage: currentPageSubject.eraseToAnyPublisher()
        )
    }
}
