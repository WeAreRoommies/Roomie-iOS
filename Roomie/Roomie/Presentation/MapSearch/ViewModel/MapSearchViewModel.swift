//
//  MapSearchViewModel.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import Foundation
import Combine

final class MapSearchViewModel {
    private let mapSearchDataSubject = CurrentValueSubject<[MapSearchModel], Never>([])
}

extension MapSearchViewModel: ViewModelType {
    struct Input {
        let searchTextFieldEnterSubject: AnyPublisher<String, Never>
    }
    
    struct Output {
        let mapSearchData: AnyPublisher<[MapSearchModel], Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.searchTextFieldEnterSubject
            .sink { [weak self] in
                self?.fetchMapSearchData(key: $0)
            }
            .store(in: cancelBag)
        
        let mapSearchData = mapSearchDataSubject
            .eraseToAnyPublisher()
        
        return Output(
            mapSearchData: mapSearchData
        )
    }
}

private extension MapSearchViewModel {
    
    // TODO: 이후 API 통신으로 변경
    func fetchMapSearchData(key: String) {
        mapSearchDataSubject.send(MapSearchModel.mockMapSearchData())
    }
}
