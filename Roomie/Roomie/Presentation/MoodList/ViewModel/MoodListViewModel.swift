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
}

extension MoodListViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let moodList: AnyPublisher<[MoodListHouse], Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillAppear
            .sink { [weak self] in self?.fetchMoodData()
            }
            .store(in: cancelBag)
        
        let moodListData = moodListDataSubject.eraseToAnyPublisher()
        
        return Output(
            moodList: moodListData
        )
    }
}

private extension MoodListViewModel {
    func fetchMoodData() {
        moodListDataSubject.send(MoodListHouse.calmListRoomData())
    }
}
