//
//  TourUserViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import Foundation
import Combine

// TODO: builder로 name, date, gender, phoneNumber를 model로 보내주기
final class TourUserViewModel {
    
    // MARK: - Property
    
    private(set) var roomID: Int
    
    private let builder: TourRequestDTO.Builder
    
    private let nameTextSubject = CurrentValueSubject<String, Never>("")
    private let dateSubject = CurrentValueSubject<String, Never>("")
    private let genderSubject = CurrentValueSubject<Gender, Never>(.none)
    private let phoneNumberTextSubject = CurrentValueSubject<String, Never>("")
    
    // MARK: - Initializer
    
    init(builder: TourRequestDTO.Builder, roomID: Int) {
        self.builder = builder
        self.roomID = roomID
    }
}

extension TourUserViewModel: ViewModelType {
    struct Input {
        let nameTextSubject: AnyPublisher<String, Never>
        let dateSubject: AnyPublisher<String, Never>
        let genderSubject: AnyPublisher<Gender, Never>
        let phoneNumberTextSubject: AnyPublisher<String, Never>
        let nextButtonSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let isPhoneNumberValid: AnyPublisher<Bool, Never>
        let isNextButtonEnabled: AnyPublisher<Bool, Never>
        let presentNextView: AnyPublisher<Void, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.nextButtonSubject
            .compactMap { $0 }
            .sink { [weak self] in
                guard let self else { return }
                guard let formattedDateString = String.formattedDateString(self.dateSubject.value) else { return }
                self.builder.setName(nameTextSubject.value)
                self.builder.setBirth(formattedDateString)
                self.builder.setGender(genderSubject.value.genderString)
                self.builder.setPhoneNumber(phoneNumberTextSubject.value)
            }
            .store(in: cancelBag)
        
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
        
        return Output(
            isPhoneNumberValid: isPhoneNumberValid,
            isNextButtonEnabled: isNextButtonEnabled,
            presentNextView: input.nextButtonSubject
        )
    }
}
