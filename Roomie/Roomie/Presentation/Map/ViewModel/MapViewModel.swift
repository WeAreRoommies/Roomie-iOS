//
//  MapViewModel.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import Foundation
import Combine

final class MapViewModel {
    private let mapDataSubject = CurrentValueSubject<[MapModel], Never>([])
    
}

extension MapViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let markerInfo: AnyPublisher<[(CGFloat, CGFloat)], Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in
                self?.fetchMapData()
            }
            .store(in: cancelBag)
        
        let markerInfo = mapDataSubject
            .map { data in
                data.map { ($0.x, $0.y)}
            }
            .eraseToAnyPublisher()
        
        return Output(markerInfo: markerInfo)
    }
}

private extension MapViewModel {
    
    // TODO: 이후 API 통신으로 변경
    func fetchMapData() {
        mapDataSubject.send(MapModel.mockMapData())
    }
}
