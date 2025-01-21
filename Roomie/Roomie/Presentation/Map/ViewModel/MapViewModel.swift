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
    
    private let mapDataSubject = CurrentValueSubject<MapResponseDTO?, Never>(nil)
    
    init(service: MapServiceProtocol, builder: MapRequestDTO.Builder) {
        self.service = service
        self.builder = builder
    }
}

extension MapViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
        let markerDidSelect: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let markersInfo: AnyPublisher<[MarkerInfo], Never>
        let markerDetailInfo: AnyPublisher<MarkerDetailInfo, Never>
        let mapListData: AnyPublisher<MapResponseDTO, Never>
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
        
        let mapListData = mapDataSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        let markersInfo = mapDataSubject
            .compactMap { data in
                data?.houses.map { MarkerInfo(houseID: $0.houseID, x: $0.x, y: $0.y) }
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
        
        return Output(
            markersInfo: markersInfo,
            markerDetailInfo: markerDetailInfo,
            mapListData: mapListData
        )
    }
}

private extension MapViewModel {
    
    // TODO: 이후 API 통신으로 변경
//    func fetchMapData() {
//        mapDataSubject.send(MapModel.mockMapData())
//    }
    
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
}
