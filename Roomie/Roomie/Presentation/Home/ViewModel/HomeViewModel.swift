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
    
    let homeDataSubject = CurrentValueSubject<HomeResponseDTO?, Never>(nil)
    let pinnedInfoDataSubject = PassthroughSubject<(Int, Bool), Never>()
    private let didTapHouseDataSubject = PassthroughSubject<Int, Never>()
    private let locationSearchDataSubject = PassthroughSubject<MapSearchResponseDTO, Never>()
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
}

extension HomeViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
        let pinnedHouseIDSubject: AnyPublisher<Int, Never>
        let searchTextFieldEnterSubject: AnyPublisher<String, Never>
        let locationDidSelectSubject: AnyPublisher<(Double, Double, String), Never>
    }
    
    struct Output {
        let userInfo: AnyPublisher<UserInfo, Never>
        let houseList: AnyPublisher<[HomeHouse], Never>
        let houseCount: AnyPublisher<Int, Never>
        let pinnedInfo: AnyPublisher<(Int,Bool), Never>
        let locationSearchData: AnyPublisher<MapSearchResponseDTO, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in
                self?.fetchHomeData()
            }
            .store(in: cancelBag)
        
        input.pinnedHouseIDSubject
            .sink { [weak self] houseID in
                self?.updatePinnedHouse(houseID: houseID)
            }
            .store(in: cancelBag)
        
        input.searchTextFieldEnterSubject
            .sink { [weak self] in
                self?.fetchSearchLocationData(query: $0)
            }
            .store(in: cancelBag)
        
        input.locationDidSelectSubject
            .sink { [weak self] (latitude, longitude, location) in
                self?.fetchUserLocation(latitude: latitude, longitude: longitude, location: location)
            }
            .store(in: cancelBag)
        
        let houseListData = homeDataSubject
            .compactMap { $0 }
            .map { house in
                house.recentlyViewedHouses.map { data in
                    HomeHouse(
                        houseID: data.houseID,
                        monthlyRent: data.monthlyRent,
                        deposit: data.deposit,
                        occupancyTypes: data.occupancyTypes,
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
            .compactMap { $0 }
            .map { data in
                UserInfo(nickname: data.nickname, location: data.location)
            }
            .eraseToAnyPublisher()
        
        let houseCount = homeDataSubject
            .compactMap { $0 }
            .map { $0.recentlyViewedHouses.count }
            .eraseToAnyPublisher()
        
        let pinnedInfoData = pinnedInfoDataSubject
            .eraseToAnyPublisher()
        
        let locationSearchData = locationSearchDataSubject
            .eraseToAnyPublisher()
        
        return Output(
            userInfo: userInfo,
            houseList: houseListData,
            houseCount: houseCount,
            pinnedInfo: pinnedInfoData,
            locationSearchData: locationSearchData
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
    
    func fetchSearchLocationData(query: String) {
        Task {
            do {
                guard let responseBody = try await service.fetchLocationSearchData(query: query),
                      let data = responseBody.data else { return }
                locationSearchDataSubject.send(data)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
    func updatePinnedHouse(houseID: Int) {
        Task {
            do {
                guard let responseBody = try await service.updatePinnedHouse(houseID: houseID),
                      let data = responseBody.data else { return }
                self.pinnedInfoDataSubject.send((houseID, data.isPinned))
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
    func fetchUserLocation(latitude: Double, longitude: Double, location: String) {
        Task {
            do {
                guard let responseBody = try await service.fetchUserLocation(
                    latitude: latitude,
                    longitude: longitude,
                    location: location
                ),
                      let data = responseBody.data else { return }
                fetchHomeData()
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
