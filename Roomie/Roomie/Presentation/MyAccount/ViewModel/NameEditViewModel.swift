//
//  NameEditViewModel.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import Foundation
import Combine

final class NameEditViewModel {
    private let nameTextSubject = CurrentValueSubject<String, Never>("")
}

extension NameEditViewModel: ViewModelType {
    struct Input {
        let nameTextSubject: AnyPublisher<String, Never>
    }
    
    struct Output {
        let isNameValid: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let isNameValid = input.nameTextSubject
            .map { [weak self] name in
                if name.isEmpty {
                    return true
                } else {
                    let nameRegex = "^[가-힣A-Za-z]+$"
                    let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
                    self?.nameTextSubject.send(name)
                    return predicate.evaluate(with: name)
                }
            }
            .eraseToAnyPublisher()
        
        return Output(isNameValid: isNameValid)
    }
}
