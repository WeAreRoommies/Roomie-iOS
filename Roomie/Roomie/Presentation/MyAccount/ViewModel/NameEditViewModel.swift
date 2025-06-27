//
//  NameEditViewModel.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import Foundation
import Combine

final class NameEditViewModel {
    private let service: MyAccountServiceProtocol
    
    private let nameTextSubject = CurrentValueSubject<String, Never>("")
    private let isSuccessSubject = PassthroughSubject<Bool, Never>()
    
    init(service: MyAccountServiceProtocol) {
        self.service = service
    }
}

extension NameEditViewModel: ViewModelType {
    struct Input {
        let nameTextSubject: AnyPublisher<String, Never>
        let editButtonDidTapSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let isNameValid: AnyPublisher<Bool, Never>
        let isSuccess: AnyPublisher<Bool, Never>
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
        
        let isSuccess = isSuccessSubject.eraseToAnyPublisher()
        
        input.editButtonDidTapSubject
            .sink { [weak self] in
                guard let self = self else { return }
                let name = self.nameTextSubject.value
                self.updateNameData(request: NameRequestDTO(name: name))
            }
            .store(in: cancelBag)
        
        return Output(
            isNameValid: isNameValid,
            isSuccess: isSuccess
        )
    }
}

private extension NameEditViewModel {
    func updateNameData(request: NameRequestDTO) {
        Task {
            do {
                guard let responseBody = try await service.updateNameData(request: request),
                      let _ = responseBody.data else { return }
                isSuccessSubject.send(true)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
