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
    
    init(service: WishListServiceProtocol) {
        self.service = service
    }
}

extension WishListViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let wishList: AnyPublisher<[WishListHouse], Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in self?.fetchWishListData()
            }
            .store(in: cancelBag)
        
        let wishListData = wishListDataSubject
            .map { house in
                house.pinnedHouses.map { data in
                    WishListHouse(
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
        
        return Output(
            wishList: wishListData
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
}
