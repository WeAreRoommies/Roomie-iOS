//
//  BirthDateEditViewModel.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import Foundation
import Combine

final class BirthDateEditViewModel {
    private let service: MyAccountServiceProtocol
    
    private let previousBirthDateSubject = CurrentValueSubject<String, Never>("")
    private let birthDateSubject = CurrentValueSubject<String, Never>("")
    private let isSuccessSubject = PassthroughSubject<Bool, Never>()
    
    init(service: MyAccountServiceProtocol) {
        self.service = service
    }
}

extension BirthDateEditViewModel: ViewModelType {
    struct Input {
        let viewWillAppearSubject: AnyPublisher<Void, Never>
        let birthDateSubject: AnyPublisher<String, Never>
        let editButtonDidTapSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let previousBirthDate: AnyPublisher<String, Never>
        let isSuccess: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let previousBirthDate = previousBirthDateSubject.eraseToAnyPublisher()
        
        input.birthDateSubject
            .compactMap { $0 }
            .compactMap { String.formattedDateString($0) }
            .sink { [weak self] date in
                guard let self = self else { return }
                self.birthDateSubject.send(date)
            }
            .store(in: cancelBag)
        
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
                let birthDate = self.birthDateSubject.value
                self.updateBirthDateData(request: BirthDateRequestDTO(birthDate: birthDate))
            }
            .store(in: cancelBag)
        
        return Output(
            previousBirthDate: previousBirthDate,
            isSuccess: isSuccess
        )
    }
}

private extension BirthDateEditViewModel {
    func fetchMyAccountData() {
        Task {
            do {
                guard let responseBody = try await service.fetchMyAccountData(),
                      let data = responseBody.data else { return }
                previousBirthDateSubject.send(data.birthDate ?? "")
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
    func updateBirthDateData(request: BirthDateRequestDTO) {
        Task {
            do {
                guard let responseBody = try await service.updateBirthDateData(request: request),
                      let _ = responseBody.data else { return }
                isSuccessSubject.send(true)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
