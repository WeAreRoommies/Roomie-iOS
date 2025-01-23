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
    
    let moodListDataSubject = CurrentValueSubject<MoodListResponseDTO?, Never>(nil)
    let pinnedInfoDataSubject = PassthroughSubject<(Int, Bool), Never>()
    
    // MARK: - Initializer
    
    init(service: MoodListServiceProtocol) {
        self.service = service
    }
}

extension MoodListViewModel: ViewModelType {
    struct Input {
        let moodListTypeSubject: AnyPublisher<String, Never>
        let pinnedHouseIDSubject: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let moodList: AnyPublisher<[MoodHouse], Never>
        let pinnedInfo: AnyPublisher<(Int,Bool), Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.moodListTypeSubject
            .map { "#\($0)" }
            .sink { [weak self] type in
                self?.fetchMoodListData(type: type)
            }
            .store(in: cancelBag)
        
        input.pinnedHouseIDSubject
            .sink { [weak self] houseID in
                self?.updatePinnedHouse(houseID: houseID)
            }
            .store(in: cancelBag)
        
        let moodListData = moodListDataSubject
            .compactMap { $0 }
            .map { $0.houses }
            .eraseToAnyPublisher()
        
        let pinnedInfoData = pinnedInfoDataSubject
            .eraseToAnyPublisher()
        
        return Output(
            moodList: moodListData,
            pinnedInfo: pinnedInfoData
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
    
    func updatePinnedHouse(houseID: Int) {
        Task {
            do {
                guard let responseBody = try await service.updatePinnedHouse(houseID: houseID),
                      let data = responseBody.data else { return }
                self.pinnedInfoDataSubject.send((houseID, data.isPinned))
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
