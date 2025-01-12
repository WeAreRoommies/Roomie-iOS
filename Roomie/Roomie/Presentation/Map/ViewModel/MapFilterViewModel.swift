//
//  MapFilterViewModel.swift
//  Roomie
//
//  Created by 예삐 on 1/12/25.
//

import Foundation
import Combine

final class MapFilterViewModel {
    private let depositMinSubject = CurrentValueSubject<Int, Never>(0)
    private let depositMaxSubject = CurrentValueSubject<Int, Never>(500)
    
    private let monthlyRentMinSubject = CurrentValueSubject<Int, Never>(0)
    private let monthlyRentMaxSubject = CurrentValueSubject<Int, Never>(500)
}

extension MapFilterViewModel: ViewModelType {
    struct Input {
        /// 보증금 텍스트필드 값
        let depositMinText: AnyPublisher<Int, Never>
        let depositMaxText: AnyPublisher<Int, Never>
        
        // 보증금 슬라이더 값
        let depositMinRange: AnyPublisher<Int, Never>
        let depositMaxRange: AnyPublisher<Int, Never>
        
        /// 월세 텍스트필드 값
        let monthlyRentMinText: AnyPublisher<Int, Never>
        let monthlyRentMaxText: AnyPublisher<Int, Never>
        
        // 월세 슬라이더 값
        let monthlyRentMinRange: AnyPublisher<Int, Never>
        let monthlyRentMaxRange: AnyPublisher<Int, Never>
    }
    
    struct Output {
        /// 보증금 텍스트필드 값
        let depositMinText: AnyPublisher<Int, Never>
        let depositMaxText: AnyPublisher<Int, Never>
        
        // 보증금 슬라이더 값
        let depositMinRange: AnyPublisher<Int, Never>
        let depositMaxRange: AnyPublisher<Int, Never>
        
        /// 월세 텍스트필드 값
        let monthlyRentMinText: AnyPublisher<Int, Never>
        let monthlyRentMaxText: AnyPublisher<Int, Never>
        
        // 월세 슬라이더 값
        let monthlyRentMinRange: AnyPublisher<Int, Never>
        let monthlyRentMaxRange: AnyPublisher<Int, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.depositMinText
            .sink { [weak self] in
                guard let self = self else { return }
                self.depositMinSubject.send($0)
            }
            .store(in: cancelBag)
        
        input.depositMaxText
            .sink { [weak self] in
                guard let self = self else { return }
                self.depositMaxSubject.send($0)
            }
            .store(in: cancelBag)
        
        input.depositMinRange
            .sink { [weak self] in
                guard let self = self else { return }
                self.depositMinSubject.send($0)
            }
            .store(in: cancelBag)
        
        input.depositMaxRange
            .sink { [weak self] in
                guard let self = self else { return }
                self.depositMaxSubject.send($0)
            }
            .store(in: cancelBag)
        
        input.monthlyRentMinText
            .sink { [weak self] in
                guard let self = self else { return }
                self.monthlyRentMinSubject.send($0)
            }
            .store(in: cancelBag)
        
        input.monthlyRentMaxText
            .sink { [weak self] in
                guard let self = self else { return }
                self.monthlyRentMaxSubject.send($0)
            }
            .store(in: cancelBag)
        
        input.monthlyRentMinRange
            .sink { [weak self] in
                guard let self = self else { return }
                self.monthlyRentMinSubject.send($0)
            }
            .store(in: cancelBag)
        
        input.monthlyRentMaxRange
            .sink { [weak self] in
                guard let self = self else { return }
                self.monthlyRentMaxSubject.send($0)
            }
            .store(in: cancelBag)
        
        let depositMin = depositMinSubject
            .eraseToAnyPublisher()
        
        let depositMax = depositMaxSubject
            .eraseToAnyPublisher()
        
        let monthlyRentMin = monthlyRentMinSubject
            .eraseToAnyPublisher()
        
        let monthlyRentMax = monthlyRentMaxSubject
            .eraseToAnyPublisher()
        
        return Output(
            depositMinText: depositMin,
            depositMaxText: depositMax,
            depositMinRange: depositMin,
            depositMaxRange: depositMax,
            monthlyRentMinText: monthlyRentMin,
            monthlyRentMaxText: monthlyRentMax,
            monthlyRentMinRange: monthlyRentMin,
            monthlyRentMaxRange: monthlyRentMax
        )
    }
}
