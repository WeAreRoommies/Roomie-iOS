//
//  MapSearchViewModel.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import Foundation
import Combine

final class MapSearchViewModel {
    private let service: MapSearchServiceProtocol
    private let mapSearchDataSubject = PassthroughSubject<MapSearchResponseDTO, Never>()
    
    init(service: MapSearchServiceProtocol) {
        self.service = service
    }
}

extension MapSearchViewModel: ViewModelType {
    struct Input {
        let searchTextFieldEnterSubject: AnyPublisher<String, Never>
    }
    
    struct Output {
        let mapSearchData: AnyPublisher<MapSearchResponseDTO, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.searchTextFieldEnterSubject
            .sink { [weak self] in
                self?.fetchMapSearchData(query: $0)
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
    func fetchMapSearchData(query: String) {
        Task {
            do {
                guard let responseBody = try await service.fetchMapSearchData(query: query),
                      let data = responseBody.data else { return }
                mapSearchDataSubject.send(data)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
