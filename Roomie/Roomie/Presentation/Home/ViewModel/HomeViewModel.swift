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
    private let service: HomeServiceProtocol
    private let homeDataSubject = PassthroughSubject<[RecentlyHouse], Never>()
    private let userDataSubject = PassthroughSubject<UserInfo, Never>()
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
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
        Task {
            do {
                guard let responseBody = try await service.fetchHomeData(),
                      let data = responseBody.data else { return }
                
                let userInfo = UserInfo(
                    name: data.name,
                    location: data.location
                )
                let houses = data.recentlyViewedHouses.map { data in
                    RecentlyHouse(
                        houseID: data.houseID,
                        monthlyRent: data.monthlyRent,
                        deposit: data.deposit,
                        occupancyType: data.occupancyTypes,
                        location: data.location,
                        genderPolicy: data.genderPolicy,
                        locationDescription: data.locationDescription,
                        isPinned: data.isPinned,
                        moodTag: data.moodTag,
                        contractTerm: data.contractTerm,
                        mainImageURL: data.mainImageURL
                    )
                }
                    .compactMap { $0 }
                userDataSubject.send(userInfo)
                homeDataSubject.send(houses)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
