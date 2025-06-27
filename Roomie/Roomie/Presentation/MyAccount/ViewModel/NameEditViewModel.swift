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
    
    private let previousNameSubject = CurrentValueSubject<String, Never>("")
    private let nameSubject = CurrentValueSubject<String, Never>("")
    private let isSuccessSubject = PassthroughSubject<Bool, Never>()
    
    init(service: MyAccountServiceProtocol) {
        self.service = service
    }
}

extension NameEditViewModel: ViewModelType {
    struct Input {
        let viewWillAppearSubject: AnyPublisher<Void, Never>
        let nameTextSubject: AnyPublisher<String, Never>
        let editButtonDidTapSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let previousName: AnyPublisher<String, Never>
        let isNameValid: AnyPublisher<Bool, Never>
        let isSuccess: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let previousName = previousNameSubject.eraseToAnyPublisher()
        
        let isNameValid = input.nameTextSubject
            .map { [weak self] name in
                if name.isEmpty {
                    return true
                } else {
                    let nameRegex = "^[가-힣A-Za-z]+$"
                    let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
                    self?.nameSubject.send(name)
                    return predicate.evaluate(with: name)
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
                let name = self.nameSubject.value
                self.updateNameData(request: NameRequestDTO(name: name))
            }
            .store(in: cancelBag)
        
        return Output(
            previousName: previousName,
            isNameValid: isNameValid,
            isSuccess: isSuccess
        )
    }
}

private extension NameEditViewModel {
    func fetchMyAccountData() {
        Task {
            do {
                guard let responseBody = try await service.fetchMyAccountData(),
                      let data = responseBody.data else { return }
                previousNameSubject.send(data.name ?? "")
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
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
