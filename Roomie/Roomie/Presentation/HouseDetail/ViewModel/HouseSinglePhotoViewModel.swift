//
//  HouseSinglePhotoViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/23/25.
//

import Foundation
import Combine

import CombineCocoa
import Kingfisher

final class HouseSinglePhotoViewModel {
    
    // MARK: - Property
    
    private let service: HouseDetailServiceProtocol
    private let houseID: Int
    
    private let houseDetailRoomsDataSubject = CurrentValueSubject<HouseDetailRoomsResponseDTO?, Never>(nil)
    
    // MARK: - Initializer
    
    init(service: HouseDetailServiceProtocol, houseID: Int) {
        self.service = service
        self.houseID = houseID
    }
}

extension HouseSinglePhotoViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let houseDetailRoomsData: AnyPublisher<HouseDetailRoomsResponseDTO, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in
                guard let self else { return }
                
                self.fetchHouseDetailRoomsData(houseID: houseID)
            }
            .store(in: cancelBag)
        
        let houseDetailRoomsData = houseDetailRoomsDataSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        return Output(houseDetailRoomsData: houseDetailRoomsData)
    }
}

private extension HouseSinglePhotoViewModel {
    func fetchHouseDetailRoomsData(houseID: Int) {
        Task {
            do {
                guard let responseBody = try await service.fetchHouseDetailRoomsData(houseID: houseID),
                      let data = responseBody.data else { return }
                houseDetailRoomsDataSubject.send(data)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}

