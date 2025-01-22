//
//  MoodListViewModel.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import Foundation
import Combine

final class MoodListViewModel {
    
    // MARK: - Property
    
    private let service: MoodListServiceProtocol
    private let moodListDataSubject = PassthroughSubject<MoodListResponseDTO, Never>()
    
    // MARK: - Initializer
    
    init(service: MoodListServiceProtocol) {
        self.service = service
    }
}

extension MoodListViewModel: ViewModelType {
    struct Input {
        let moodListTypeSubject: AnyPublisher<String, Never>
    }
    
    struct Output {
        let moodList: AnyPublisher<[MoodHouse], Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.moodListTypeSubject
            .map { "#\($0)" }
            .sink { [weak self] type in
                self?.fetchMoodListData(type: type)
            }
            .store(in: cancelBag)
        
        let moodListData = moodListDataSubject
            .map { $0.houses }
            .eraseToAnyPublisher()
        
        return Output(
            moodList: moodListData
        )
    }
}

private extension MoodListViewModel {
    func fetchMoodListData(type: String) {
        Task {
            do {
                guard let responseBody = try await service.fetchMoodListData(moodTag: type),
                      let data = responseBody.data else { return }
                moodListDataSubject.send(data)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
