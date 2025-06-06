//
//  MyPageViewModel.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import Foundation
import Combine

final class MyPageViewModel {
    private let service: MyPageServiceProtocol
    private let userNameDataSubject = CurrentValueSubject<String?, Never>(nil)
    private let socialTypeDataSubject = CurrentValueSubject<String?, Never>(nil)
    
    init(service: MyPageServiceProtocol) {
        self.service = service
    }
}

extension MyPageViewModel: ViewModelType {
    struct Input {
        let viewWillAppearSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let userName: AnyPublisher<String, Never>
        let socialType: AnyPublisher<String, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppearSubject
            .sink { [weak self] in
                self?.fetchMyPageData()
            }
            .store(in: cancelBag)
        
        let userNameData = userNameDataSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        let socialTypeData = socialTypeDataSubject
            .compactMap { $0 }
            .map { rawType -> String in
                switch rawType.uppercased() {
                case "KAKAO":
                    return "카카오"
                case "APPLE":
                    return "애플"
                default:
                    return rawType
                }
            }
            .eraseToAnyPublisher()
        
        return Output(
            userName: userNameData,
            socialType: socialTypeData
        )
    }
}

private extension MyPageViewModel {
    func fetchMyPageData() {
        Task {
            do {
                guard let responseBody = try await service.fetchMyPageData(),
                      let data = responseBody.data else { return }
                userNameDataSubject.send(data.nickname)
                socialTypeDataSubject.send(data.socialType)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
