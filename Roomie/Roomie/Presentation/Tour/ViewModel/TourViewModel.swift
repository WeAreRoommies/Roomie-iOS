//
//  TourViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import Foundation
import Combine

final class TourViewModel {
    
    // MARK: - Property
    
    private let nameTextSubject = PassthroughSubject<String, Never>()
    private let dateSubject = PassthroughSubject<String, Never>()
    private let genderSubject = PassthroughSubject<Gender, Never>()
    private let phoneNumberTextSubject = PassthroughSubject<String, Never>()   
}

extension TourViewModel: ViewModelType {
    struct Input {
        let nameTextSubject: AnyPublisher<String, Never>
        let dateSubject: AnyPublisher<String, Never>
        let genderSubject: AnyPublisher<Gender, Never>
        let phoneNumberTextSubject: AnyPublisher<String, Never>
    }
    
    struct Output {
        let isPhoneNumberValid: AnyPublisher<Bool, Never>
        let isNextButtonEnabled: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.nameTextSubject
            .sink { [weak self] name in
                self?.nameTextSubject.send(name)
            }
            .store(in: cancelBag)
        
        input.dateSubject
            .sink { [weak self] date in
                self?.dateSubject.send(date)
            }
            .store(in: cancelBag)
        
        input.genderSubject
            .scan(Gender.none) { previous, current in
                return previous == current ? .none : current
            }
            .sink { [weak self] gender in
                self?.genderSubject.send(gender)
            }
            .store(in: cancelBag)
        
        let isPhoneNumberValid = input.phoneNumberTextSubject
            .map { [weak self] phoneNumber in
                if phoneNumber.isEmpty {
                    return true
                } else {
                    let phoneRegex = "^010\\d{8}$"
                    let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
                    self?.phoneNumberTextSubject.send(phoneNumber)
                    return predicate.evaluate(with: phoneNumber)
                }
            }
            .eraseToAnyPublisher()
        
        let isNextButtonEnabled = Publishers.CombineLatest4(
            self.nameTextSubject.map { !$0.isEmpty },
            self.dateSubject.map { !$0.isEmpty },
            self.genderSubject.map { $0 != .none },
            isPhoneNumberValid
        )
            .map { isNameValid, isDateValid, isGenderValid, isPhoneNumberValid in
                isNameValid && isDateValid && isGenderValid && isPhoneNumberValid
            }
            .eraseToAnyPublisher()
        
        return Output(isPhoneNumberValid: isPhoneNumberValid, isNextButtonEnabled: isNextButtonEnabled)
    }
}
