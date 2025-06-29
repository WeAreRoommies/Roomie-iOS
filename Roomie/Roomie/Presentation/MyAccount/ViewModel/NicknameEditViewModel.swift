//
//  NicknameEditViewModel.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import Foundation
import Combine

final class NicknameEditViewModel {
    private let service: MyAccountServiceProtocol
    
    private let previousNicknameSubject = CurrentValueSubject<String, Never>("")
    private let nicknameSubject = CurrentValueSubject<String, Never>("")
    private let isSuccessSubject = PassthroughSubject<Bool, Never>()
    
    init(service: MyAccountServiceProtocol) {
        self.service = service
    }
}

extension NicknameEditViewModel: ViewModelType {
    struct Input {
        let viewWillAppearSubject: AnyPublisher<Void, Never>
        let nicknameTextSubject: AnyPublisher<String, Never>
        let editButtonDidTapSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let previousNickname: AnyPublisher<String, Never>
        let isNicknameValid: AnyPublisher<Bool, Never>
        let isSuccess: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let previousNickname = previousNicknameSubject.eraseToAnyPublisher()
        
        let isNicknameValid = input.nicknameTextSubject
            .map { [weak self] name in
                if name.isEmpty {
                    return true
                } else {
                    let nicknameRegex = "^[가-힣A-Za-z0-9]{2,12}$"
                    let predicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
                    self?.nicknameSubject.send(name)
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
                let nickname = self.nicknameSubject.value
                self.updateNicknameData(request: NicknameRequestDTO(nickname: nickname))
            }
            .store(in: cancelBag)
        
        return Output(
            previousNickname: previousNickname,
            isNicknameValid: isNicknameValid,
            isSuccess: isSuccess
        )
    }
}

private extension NicknameEditViewModel {
    func fetchMyAccountData() {
        Task {
            do {
                guard let responseBody = try await service.fetchMyAccountData(),
                      let data = responseBody.data else { return }
                previousNicknameSubject.send(data.nickname)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
    func updateNicknameData(request: NicknameRequestDTO) {
        Task {
            do {
                guard let responseBody = try await service.updateNicknameData(request: request),
                      let _ = responseBody.data else { return }
                isSuccessSubject.send(true)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
