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
    
    private let wishListDataSubject = PassthroughSubject<[WishListHouse], Never>()
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
        
        let wishListData = wishListDataSubject.eraseToAnyPublisher()
        
        return Output(
            wishList: wishListData
        )
    }
}

private extension WishListViewModel {
    func fetchWishListData() {
        wishListDataSubject.send(WishListHouse.mockWishListData())
    }
}
