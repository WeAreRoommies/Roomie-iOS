//
//  MyAccountViewModel.swift
//  Roomie
//
//  Created by 예삐 on 6/6/25.
//

import Foundation
import Combine

final class MyAccountViewModel {
    private let service: MyAccountServiceProtocol
    private let socialTypeDataSubject = CurrentValueSubject<String?, Never>(nil)
    private let nameDataSubject = CurrentValueSubject<String?, Never>(nil)
    private let nicknameDataSubject = CurrentValueSubject<String?, Never>(nil)
    private let birthDateDataSubject = CurrentValueSubject<String?, Never>(nil)
    private let phoneNumberDataSubject = CurrentValueSubject<String?, Never>(nil)
    private let genderDataSubject = CurrentValueSubject<String?, Never>(nil)
    
    init(service: MyAccountServiceProtocol) {
        self.service = service
    }
}

extension MyAccountViewModel: ViewModelType {
    struct Input {
        let viewWillAppearSubject: AnyPublisher<Void, Never>
        let logoutButtonDidTapSubject: AnyPublisher<Void, Never>
        let signoutButtonDidTapSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let nickname: AnyPublisher<String, Never>
        let socialType: AnyPublisher<SocialType, Never>
        let name: AnyPublisher<String, Never>
        let birthDate: AnyPublisher<String, Never>
        let phoneNumber: AnyPublisher<String, Never>
        let gender: AnyPublisher<String, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppearSubject
            .sink { [weak self] in
                self?.fetchMyAccountData()
            }
            .store(in: cancelBag)
        
        input.logoutButtonDidTapSubject
            .sink { [weak self] in
                guard let self else { return }
                self.authLogout()
            }
            .store(in: cancelBag)
        
        input.signoutButtonDidTapSubject
            .sink { [weak self] in
                guard let self else { return }
                self.authSignout()
            }
            .store(in: cancelBag)
        
        let nicknameData = nicknameDataSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        let socialTypeData = socialTypeDataSubject
            .compactMap { $0 }
            .map { socialType in
                switch socialType {
                case "KAKAO":
                    return SocialType.kakao
                case "APPLE":
                    return SocialType.apple
                default:
                    return SocialType.apple
                }
            }
            .eraseToAnyPublisher()
        
        let nameData = nameDataSubject
            .map { $0 ?? "정보없음" }
            .eraseToAnyPublisher()
        
        let birthDateData = birthDateDataSubject
            .map { $0 ?? "정보없음" }
            .eraseToAnyPublisher()
        
        let phoneNumberData = phoneNumberDataSubject
            .map { $0 ?? "정보없음" }
            .eraseToAnyPublisher()
        
        let genderData = genderDataSubject
            .compactMap { gender in
                switch gender {
                case Gender.male.apiValue:
                    return Gender.male.genderString
                case Gender.female.apiValue:
                    return Gender.female.genderString
                default:
                    return "정보없음"
                }
            }
            .eraseToAnyPublisher()
        
        return Output(
            nickname: nicknameData,
            socialType: socialTypeData,
            name: nameData,
            birthDate: birthDateData,
            phoneNumber: phoneNumberData,
            gender: genderData
        )
    }
}

private extension MyAccountViewModel {
    func fetchMyAccountData() {
        Task {
            do {
                guard let responseBody = try await service.fetchMyAccountData(),
                      let data = responseBody.data else { return }
                nicknameDataSubject.send(data.nickname)
                socialTypeDataSubject.send(data.socialType)
                nameDataSubject.send(data.name)
                birthDateDataSubject.send(data.birthDate)
                phoneNumberDataSubject.send(data.phoneNumber)
                genderDataSubject.send(data.gender)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
    func authLogout() {
        guard let refreshToken = TokenManager.shared.fetchRefreshToken() else { return }
        
        Task {
            do {
                guard let _ = try await service.authLogout(refreshToken: refreshToken) else { return }
                NotificationCenter.default.post(name: Notification.shouldLogout, object: nil)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
    func authSignout() {
        guard let refreshToken = TokenManager.shared.fetchRefreshToken() else { return }
        
        Task {
            do {
                guard let _ = try await service.authSignout(refreshToken: refreshToken) else { return }
                NotificationCenter.default.post(name: Notification.shouldLogout, object: nil)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
