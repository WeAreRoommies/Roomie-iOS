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
    private let userNameDataSubject = CurrentValueSubject<MyPageResponseDTO?, Never>(nil)
    
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
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppearSubject
            .sink { [weak self] in
                self?.fetchMyPageData()
            }
            .store(in: cancelBag)
        
        let userNameData = userNameDataSubject
            .compactMap { $0?.name }
            .eraseToAnyPublisher()
        
        return Output(userName: userNameData)
    }
}

private extension MyPageViewModel {
    func fetchMyPageData() {
        Task {
            do {
                guard let responseBody = try await service.fetchMyPageData(),
                      let data = responseBody.data else { return }
                userNameDataSubject.send(data)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
