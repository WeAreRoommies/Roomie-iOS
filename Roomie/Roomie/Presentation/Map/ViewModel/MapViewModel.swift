//
//  MapViewModel.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import Foundation
import Combine

final class MapViewModel {
    private let service: MapServiceProtocol
    private let builder: MapRequestDTO.Builder
    
    private var houseID: Int?
    
    let mapDataSubject = CurrentValueSubject<MapResponseDTO?, Never>(nil)
    private let pinnedInfoSubject = PassthroughSubject<(Int, Bool), Never>()
    
    init(service: MapServiceProtocol, builder: MapRequestDTO.Builder) {
        self.service = service
        self.builder = builder
    }
}

extension MapViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
        let markerDidSelect: AnyPublisher<Int, Never>
        let eraseButtonDidTap: AnyPublisher<Void, Never>
        let pinnedHouseID: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let markersInfo: AnyPublisher<[MarkerInfo], Never>
        let markerDetailInfo: AnyPublisher<MarkerDetailInfo, Never>
        let mapListData: AnyPublisher<MapResponseDTO, Never>
        let defaultLocationInfo: AnyPublisher<(Double, Double), Never>
        let pinnedInfo: AnyPublisher<(Int, Bool), Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in
                guard let self = self else { return }
                self.fetchMapData(request: builder.build())
            }
            .store(in: cancelBag)
        
        input.markerDidSelect
            .sink { [weak self] houseID in
                self?.houseID = houseID
            }
            .store(in: cancelBag)
        
        input.eraseButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                self.builder.setLocation("서울특별시 마포구 노고산동")
                self.fetchMapData(request: builder.build())
            }
            .store(in: cancelBag)
        
        input.pinnedHouseID
            .sink { [weak self] houseID in
                guard let self = self else { return }
                self.updatePinnedHouse(houseID: houseID)
            }
            .store(in: cancelBag)
        
        let pinnedInfo = pinnedInfoSubject
            .eraseToAnyPublisher()
        
        let mapListData = mapDataSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        let markersInfo = mapDataSubject
            .compactMap { data in
                data?.houses.map { MarkerInfo(houseID: $0.houseID, x: $0.latitude, y: $0.longitude) }
            }
            .eraseToAnyPublisher()
        
        let markerDetailInfo = input.markerDidSelect
            .map { [weak self] houseID in
                self?.houseID = houseID
                return self?.mapDataSubject.value?.houses.first { $0.houseID == houseID }
                    .map { data in
                        MarkerDetailInfo(
                            monthlyRent: data.monthlyRent,
                            deposit: data.deposit,
                            occupancyType: data.occupancyTypes,
                            location: data.location,
                            genderPolicy: data.genderPolicy,
                            locationDescription: data.locationDescription,
                            isPinned: data.isPinned,
                            moodTag: data.moodTag,
                            contractTerm: data.contractTerm
                        )
                    }
            }
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        let defaultLocationInfo = input.eraseButtonDidTap
            .map { (37.567764, 126.916784) }
            .eraseToAnyPublisher()
        
        return Output(
            markersInfo: markersInfo,
            markerDetailInfo: markerDetailInfo,
            mapListData: mapListData,
            defaultLocationInfo: defaultLocationInfo,
            pinnedInfo: pinnedInfo
        )
    }
}

private extension MapViewModel {
    func fetchMapData(request: MapRequestDTO) {
        Task {
            do {
                guard let responseBody = try await service.fetchMapData(request: request),
                      let data = responseBody.data else { return }
                mapDataSubject.send(data)
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
                pinnedInfoSubject.send((houseID, data.isPinned))
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
