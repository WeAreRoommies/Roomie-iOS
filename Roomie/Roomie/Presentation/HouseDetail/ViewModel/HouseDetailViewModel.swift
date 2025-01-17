//
//  HouseDetailViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import Foundation
import Combine

final class HouseDetailViewModel {
    private let houseDetailSubject = PassthroughSubject<HouseDetailModel, Never>()
    // TODO: Published Data로
}

extension HouseDetailViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let houseInfo: AnyPublisher<HouseInfoData, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        
        input.viewWillAppear
            .sink { [weak self] in
                guard let self else { return }
                self.fetchHouseDetailData()
            }
            .store(in: cancelBag)
        
        let houseInfoData = houseDetailSubject
            .map { data in
                HouseInfoData(
                    name: data.houseInfo.name,
                    title: "월세 \(data.houseInfo.monthlyRent)/보증금 \(data.houseInfo.deposit)",
                    location: data.houseInfo.location,
                    occupancyTypes: data.houseInfo.occupancyTypes,
                    occupancyStatus: data.houseInfo.occupancyStatus,
                    genderPolicy: data.houseInfo.genderPolicy,
                    contractTerm: data.houseInfo.contractTerm
                )
            }
            .eraseToAnyPublisher()
        
        return Output(houseInfo: houseInfoData)
    }
}

private extension HouseDetailViewModel {
    
    // TODO: 이후 API 통신으로 변경
    func fetchHouseDetailData() {
        houseDetailSubject.send(HouseDetailModel.mockData())
    }
}
