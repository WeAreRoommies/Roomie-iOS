//
//  HouseAllPhotoViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/23/25.
//

import Foundation
import Combine

import CombineCocoa
import Kingfisher

final class HouseAllPhotoViewModel {
    
    // MARK: - Property
    
    private let service: HouseDetailServiceProtocol
    private let houseID: Int
    
    private let houseDetailImagesDataSubject = CurrentValueSubject<HouseDetailImagesResponseDTO?, Never>(nil)
    private let houseDetailRoomsDataSubject = CurrentValueSubject<HouseDetailRoomsResponseDTO?, Never>(nil)
    
    // MARK: - Initializer
    
    init(service: HouseDetailServiceProtocol, houseID: Int) {
        self.houseID = houseID
        self.service = service
    }
}

extension HouseAllPhotoViewModel: ViewModelType {
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let houseDetailImagesData: AnyPublisher<HouseDetailImagesResponseDTO, Never>
        let houseDetailRoomsData: AnyPublisher<HouseDetailRoomsResponseDTO, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewDidLoad
            .sink { [weak self] in
                guard let self else { return }
                
                self.fetchHouseDetailImagesData(houseID: houseID)
                self.fetchHouseDetailRoomsData(houseID: houseID)
            }
            .store(in: cancelBag)
        
        let houseDetailImagesData = houseDetailImagesDataSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        let houseDetailRoomsData = houseDetailRoomsDataSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        return Output(
            houseDetailImagesData: houseDetailImagesData,
            houseDetailRoomsData: houseDetailRoomsData
        )
    }
}

private extension HouseAllPhotoViewModel {
    func fetchHouseDetailImagesData(houseID: Int) {
        Task {
            do {
                guard let responseBody = try await service.fetchHouseDetailImagesData(houseID: houseID),
                      let data = responseBody.data else { return }
                houseDetailImagesDataSubject.send(data)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
    
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
