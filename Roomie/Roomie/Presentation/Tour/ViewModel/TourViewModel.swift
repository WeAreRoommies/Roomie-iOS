//
//  TourViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import Foundation
import Combine

final class TourViewModel {
    
}

extension TourViewModel: ViewModelType {
    struct Input {
        let phoneNumberSubject: AnyPublisher<String, Never>
    }
    
    struct Output {
        let isPhoneNumberValid: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let isPhoneNumberValid = input.phoneNumberSubject
            .map { phoneNumber in
                if phoneNumber.isEmpty {
                    return true
                } else {
                    let phoneRegex = "^010\\d{8}$"
                    let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
                    return predicate.evaluate(with: phoneNumber)
                }
            }
            .eraseToAnyPublisher()
        
        return Output(isPhoneNumberValid: isPhoneNumberValid)
    }
    
}
