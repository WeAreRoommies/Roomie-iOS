//
//  GenderEditViewModel.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import Foundation
import Combine

final class GenderEditViewModel {
    private let service: MyAccountServiceProtocol
    
    private let previousGenderSubject = CurrentValueSubject<String, Never>("")
    private let genderSubject = CurrentValueSubject<String, Never>("")
    private let isSuccessSubject = PassthroughSubject<Bool, Never>()
    
    init(service: MyAccountServiceProtocol) {
        self.service = service
    }
}

extension GenderEditViewModel: ViewModelType {
    struct Input {
        let viewWillAppearSubject: AnyPublisher<Void, Never>
        let maleButtonDidTapSubject: AnyPublisher<Void, Never>
        let femaleButtonDidTapSubject: AnyPublisher<Void, Never>
        let editButtonDidTapSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let previousGender: AnyPublisher<String, Never>
        let gender: AnyPublisher<String, Never>
        let isSuccess: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let previousGender = previousGenderSubject.eraseToAnyPublisher()
        
        let gender = genderSubject.eraseToAnyPublisher()
        
        let isSuccess = isSuccessSubject.eraseToAnyPublisher()
        
        input.viewWillAppearSubject
            .sink { [weak self] in
                guard let self = self else { return }
                self.fetchMyAccountData()
            }
            .store(in: cancelBag)
        
        input.maleButtonDidTapSubject
            .sink { [weak self] in
                guard let self = self else { return }
                self.genderSubject.send(Gender.male.genderString)
            }
            .store(in: cancelBag)
        
        input.femaleButtonDidTapSubject
            .sink { [weak self] in
                guard let self = self else { return }
                self.genderSubject.send(Gender.female.genderString)
            }
            .store(in: cancelBag)
        
        input.editButtonDidTapSubject
            .sink { [weak self] in
                guard let self = self else { return }
                var gender = self.genderSubject.value
                
                switch gender {
                case Gender.male.genderString:
                    gender = Gender.male.apiValue
                case Gender.female.genderString:
                    gender = Gender.female.apiValue
                default:
                    break
                }
                
                self.updateGenderData(request: GenderRequestDTO(gender: gender))
            }
            .store(in: cancelBag)
        
        return Output(
            previousGender: previousGender,
            gender: gender,
            isSuccess: isSuccess
        )
    }
}

private extension GenderEditViewModel {
    func fetchMyAccountData() {
        Task {
            do {
                guard let responseBody = try await service.fetchMyAccountData(),
                      let data = responseBody.data else { return }
                previousGenderSubject.send(data.gender ?? "")
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
    func updateGenderData(request: GenderRequestDTO) {
        Task {
            do {
                guard let responseBody = try await service.updateGenderData(request: request),
                      let _ = responseBody.data else { return }
                isSuccessSubject.send(true)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
