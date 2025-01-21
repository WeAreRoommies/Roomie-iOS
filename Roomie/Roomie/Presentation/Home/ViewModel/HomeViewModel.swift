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
    private let homeDataSubject = PassthroughSubject<HomeResponseDTO, Never>()
    
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
        let houseCount: AnyPublisher<Int, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in
                self?.fetchHomeData()
            }
            .store(in: cancelBag)
        
        
        let houseListData = homeDataSubject
            .map { house in
                house.recentlyViewedHouses.map { data in
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
            }
            .eraseToAnyPublisher()
        
        let userInfo = homeDataSubject
            .map { data in
                UserInfo(name: data.name, location: data.location)
            }
            .eraseToAnyPublisher()
        
        let houseCount = homeDataSubject
            .map { $0.recentlyViewedHouses.count }
            .eraseToAnyPublisher()
        
        return Output(
            userInfo: userInfo,
            houseList: houseListData,
            houseCount: houseCount
        )
    }
}

private extension HomeViewModel {
    func fetchHomeData() {
        Task {
            do {
                guard let responseBody = try await service.fetchHomeData(),
                      let data = responseBody.data else { return }
                homeDataSubject.send(data)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
