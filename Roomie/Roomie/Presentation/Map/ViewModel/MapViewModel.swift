//
//  MapViewModel.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import Foundation
import Combine

final class MapViewModel {
    private var houseID: Int?
    
    private let mapDataSubject = CurrentValueSubject<[MapModel], Never>([])
}

extension MapViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
        let markerDidSelect: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let markersInfo: AnyPublisher<[MarkerInfo], Never>
        let markerDetailInfo: AnyPublisher<MarkerDetailInfo, Never>
        let mapListData: AnyPublisher<[MapModel], Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in
                self?.fetchMapData()
            }
            .store(in: cancelBag)
        
        input.markerDidSelect
            .sink { [weak self] houseID in
                self?.houseID = houseID
            }
            .store(in: cancelBag)
        
        let mapListData = mapDataSubject
            .eraseToAnyPublisher()
        
        let markersInfo = mapDataSubject
            .map { data in
                data.map { MarkerInfo(houseID: $0.houseID, x: $0.x, y: $0.y) }
            }
            .eraseToAnyPublisher()
        
        let markerDetailInfo = input.markerDidSelect
            .map { [weak self] houseID in
                self?.houseID = houseID
                return self?.mapDataSubject.value.first { $0.houseID == houseID }
                    .map { data in
                        MarkerDetailInfo(
                            monthlyRent: data.monthlyRent,
                            deposit: data.deposit,
                            occupancyType: data.occupancyType,
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
    func fetchMapData() {
        mapDataSubject.send(MapModel.mockMapData())
    }
}
