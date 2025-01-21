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
    
    private let moodListDataSubject = PassthroughSubject<[MoodListHouse], Never>()
    private let moodType: MoodType
    
    // MARK: - Initializer
    
    init(moodType: MoodType) {
        self.moodType = moodType
    }
}

extension MoodListViewModel: ViewModelType {
    struct Input {
        let moodListTypeSubject: AnyPublisher<String, Never>
    }
    
    struct Output {
        let moodList: AnyPublisher<[MoodListHouse], Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.moodListTypeSubject
            .sink { [weak self] in
                self?.fetchMoodListData(type: $0)
            }
            .store(in: cancelBag)
        
        let moodListData = moodListDataSubject.eraseToAnyPublisher()
        
        return Output(
            moodList: moodListData
        )
    }
}

private extension MoodListViewModel {
    func fetchMoodListData(type:String) {
        switch type {
        case MoodType.calm.title:
            return moodListDataSubject.send(MoodListHouse.calmListRoomData())
        case MoodType.lively.title:
            return moodListDataSubject.send(MoodListHouse.livelyListRoomData())
        case MoodType.neat.title:
            return moodListDataSubject.send(MoodListHouse.neatListRoomData())
        default:
            return
        }
    }
}
