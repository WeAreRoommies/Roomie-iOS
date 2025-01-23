//
//  WishListViewModel.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import Foundation
import Combine

final class WishListViewModel {
    
    // MARK: - Property
    
    private let service: WishListServiceProtocol
    
    let wishListDataSubject = CurrentValueSubject<WishListResponseDTO?, Never>(nil)
    let pinnedInfoDataSubject = PassthroughSubject<(Int, Bool), Never>()
    private let didTapHouseDataSubject = PassthroughSubject<Int, Never>()
    
    init(service: WishListServiceProtocol) {
        self.service = service
    }
}

extension WishListViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
        let pinnedHouseIDSubject: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let wishList: AnyPublisher<[WishHouse], Never>
        let pinnedInfo: AnyPublisher<(Int,Bool), Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in
                self?.fetchWishListData()
            }
            .store(in: cancelBag)
        
        input.pinnedHouseIDSubject
            .sink { [weak self] houseID in
                self?.updatePinnedHouse(houseID: houseID)
            }
            .store(in: cancelBag)
        
        let wishListData = wishListDataSubject
            .compactMap { $0 }
            .map { house in
                house.pinnedHouses.map { data in
                    WishHouse(
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
        
        let pinnedInfoData = pinnedInfoDataSubject
            .eraseToAnyPublisher()
        
        return Output(
            wishList: wishListData,
            pinnedInfo: pinnedInfoData
        )
    }
}

private extension WishListViewModel {
    func fetchWishListData() {
        Task {
            do {
                guard let responseBody = try await service.fetchWishListData(),
                      let data = responseBody.data else { return }
                wishListDataSubject.send(data)
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
}
