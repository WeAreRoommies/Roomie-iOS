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
    private let builder: MapRequestDTO.Builder
    
    private let mapSearchDataSubject = PassthroughSubject<MapSearchResponseDTO, Never>()
    
    init(service: MapSearchServiceProtocol, builder: MapRequestDTO.Builder) {
        self.service = service
        self.builder = builder
    }
}

extension MapSearchViewModel: ViewModelType {
    struct Input {
        let searchTextFieldEnterSubject: AnyPublisher<String, Never>
        let locationDidSelectSubject: AnyPublisher<AddressInfo, Never>
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
        
        input.locationDidSelectSubject
            .sink { [weak self] address in
                guard let self = self else { return }
                self.builder.setAddress(address.address)
                self.builder.setLatitude(address.latitude)
                self.builder.setLongitude(address.longitude)
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
