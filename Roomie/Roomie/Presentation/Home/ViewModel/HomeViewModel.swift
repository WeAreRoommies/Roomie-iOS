//
//  HomeViewModel.swift
//  Roomie
//
//  Created by MaengKim on 1/7/25.
//

import Foundation
import Combine

final class HomeViewModel {
    
    // MARK: - Property
    
    private let homeDataSubject = PassthroughSubject<[RecentlyHouse], Never>()
    private let userDataSubject = PassthroughSubject<UserInfo, Never>()
}

extension HomeViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let userInfo: AnyPublisher<UserInfo, Never>
        let houseList: AnyPublisher<[RecentlyHouse], Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in
                self?.fetchHomeData()
            }
            .store(in: cancelBag)
        
        let houseListData = homeDataSubject.eraseToAnyPublisher()
        let userInfo = userDataSubject.eraseToAnyPublisher()
        
        return Output(
            userInfo: userInfo,
            houseList: houseListData
        )
    }
}

private extension HomeViewModel {
    func fetchHomeData() {
        homeDataSubject.send(RecentlyHouse.mockHomeData())
        userDataSubject.send(UserInfo.mockUserData())
    }
}
