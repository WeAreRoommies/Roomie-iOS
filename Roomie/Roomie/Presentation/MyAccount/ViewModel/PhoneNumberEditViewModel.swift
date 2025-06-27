//
//  PhoneNumberEditViewModel.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import Foundation
import Combine

final class PhoneNumberEditViewModel {
    private let service: MyAccountServiceProtocol
    
    private let previousPhoneNumberSubject = CurrentValueSubject<String, Never>("")
    private let phoneNumberSubject = CurrentValueSubject<String, Never>("")
    private let isSuccessSubject = PassthroughSubject<Bool, Never>()
    
    init(service: MyAccountServiceProtocol) {
        self.service = service
    }
}

extension PhoneNumberEditViewModel: ViewModelType {
    struct Input {
        let viewWillAppearSubject: AnyPublisher<Void, Never>
        let phoneNumberTextSubject: AnyPublisher<String, Never>
        let editButtonDidTapSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let previousPhoneNumber: AnyPublisher<String, Never>
        let isPhoneNumberValid: AnyPublisher<Bool, Never>
        let isSuccess: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let previousPhoneNumber = previousPhoneNumberSubject.eraseToAnyPublisher()
        
        let isPhoneNumberValid = input.phoneNumberTextSubject
            .map { [weak self] phoneNumber in
                if phoneNumber.isEmpty {
                    return true
                } else {
                    let phoneNumberRegex = "^01[016789]-?\\d{4}-?\\d{4}$"
                    let predicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
                    self?.phoneNumberSubject.send(phoneNumber)
                    return predicate.evaluate(with: phoneNumber)
                }
            }
            .eraseToAnyPublisher()
        
        let isSuccess = isSuccessSubject.eraseToAnyPublisher()
        
        input.viewWillAppearSubject
            .sink { [weak self] in
                guard let self = self else { return }
                self.fetchMyAccountData()
            }
            .store(in: cancelBag)
        
        input.editButtonDidTapSubject
            .sink { [weak self] in
                guard let self = self else { return }
                let phoneNumber = self.phoneNumberSubject.value
                self.updatePhoneNumberData(request: PhoneNumberRequestDTO(phoneNumber: phoneNumber))
            }
            .store(in: cancelBag)
        
        return Output(
            previousPhoneNumber: previousPhoneNumber,
            isPhoneNumberValid: isPhoneNumberValid,
            isSuccess: isSuccess
        )
    }
}

private extension PhoneNumberEditViewModel {
    func fetchMyAccountData() {
        Task {
            do {
                guard let responseBody = try await service.fetchMyAccountData(),
                      let data = responseBody.data else { return }
                previousPhoneNumberSubject.send(data.phoneNumber ?? "")
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
    func updatePhoneNumberData(request: PhoneNumberRequestDTO) {
        Task {
            do {
                guard let responseBody = try await service.updatePhoneNumberData(request: request),
                      let _ = responseBody.data else { return }
                isSuccessSubject.send(true)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
