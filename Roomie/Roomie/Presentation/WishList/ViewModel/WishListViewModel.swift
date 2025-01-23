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
    private let wishListDataSubject = PassthroughSubject<WishListResponseDTO, Never>()
    
    private(set) var wishListData: [WishHouse] = []
    
    let pinnedWishSubject = PassthroughSubject<(Int, Bool), Never>()
    
    init(service: WishListServiceProtocol) {
        self.service = service
    }
}

extension WishListViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
        let pinnedWishSubject: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let wishList: AnyPublisher<[WishHouse], Never>
        let pinnedWish: AnyPublisher<(Int,Bool), Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in
                self?.fetchWishListData()
            }
            .store(in: cancelBag)
        
        input.pinnedWishSubject
            .sink { [weak self] houseID in
                self?.updatePinnedHouse(houseID: houseID)
            }
            .store(in: cancelBag)
        
        let wishListData = wishListDataSubject
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
            .handleEvents(receiveOutput: { [weak self] list in
                self?.wishListData = list
            })
            .eraseToAnyPublisher()
        
        let pinned = pinnedWishSubject
            .eraseToAnyPublisher()
        
        return Output(
            wishList: wishListData,
            pinnedWish: pinned
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
            Task {
                 do {
                     guard let responseBody = try await service.updatePinnedHouse(houseID: houseID),
                           let data = responseBody.data else { return }
                     
                     if let index = self.wishListData.firstIndex(where: { $0.houseID == houseID }) {
                         self.wishListData[index].isPinned = data.isPinned
                         self.pinnedWishSubject.send((houseID, data.isPinned))
                     }
                 } catch {
                     print(">>> \(error.localizedDescription) : \(#function)")
                 }
             }
        }
    }
}
