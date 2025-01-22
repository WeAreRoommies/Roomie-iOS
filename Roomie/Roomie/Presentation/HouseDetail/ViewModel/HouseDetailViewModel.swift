//
//  HouseDetailViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import Foundation
import Combine

final class HouseDetailViewModel {
    
    // MARK: - Property
    
    private let service: HouseDetailServiceProtocol
    
    private let houseDetailDataSubject = CurrentValueSubject<HouseDetailResponseDTO?, Never>(nil)
    
    private let roomIDSubject = PassthroughSubject<Int, Never>()
    
    @Published private(set) var roomInfos: [RoomInfo] = []
    @Published private(set) var roommateInfos: [RoommateInfo] = []
    
    // MARK: - Initializer
    
    init(service: HouseDetailServiceProtocol) {
        self.service = service
    }
}

extension HouseDetailViewModel: ViewModelType {
    struct Input {
        let viewWillApper: AnyPublisher<Void, Never>
        let roomIDSubject: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let navigationBarTitle: AnyPublisher<String, Never>
        let houseMainInfo: AnyPublisher<HouseMainInfo, Never>
        let roomMoodInfo: AnyPublisher<RoomMoodInfo, Never>
        let safetyLivingFacilityInfo: AnyPublisher<[String], Never>
        let kitchenFacilityInfo: AnyPublisher<[String], Never>
        let isTourApplyButtonEnabled: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewWillApper
            .sink { [weak self] in
                guard let self else { return }
                
                // TODO: houseID 받아오기
                self.fetchHouseDetailData(houseID: 1)
            }
            .store(in: cancelBag)
        
        input.roomIDSubject
            .sink { [weak self] roomID in
                guard let self else { return }
                self.roomIDSubject.send(roomID)
            }
            .store(in: cancelBag)
        
        let navigationBarTitle = houseDetailDataSubject
            .compactMap { $0 }
            .map { data in
                "\(data.houseInfo.monthlyRent)/\(data.houseInfo.deposit)"
            }
            .eraseToAnyPublisher()
        
        let houseMainInfo = houseDetailDataSubject
            .compactMap { $0 }
            .map { data in
                HouseMainInfo(
                    mainImageURL: data.houseInfo.mainImageURL,
                    name: data.houseInfo.name,
                    title: "월세 \(data.houseInfo.monthlyRent)/보증금 \(data.houseInfo.deposit)",
                    location: data.houseInfo.location,
                    occupancyTypes: data.houseInfo.occupancyTypes,
                    occupancyStatus: data.houseInfo.occupancyStatus,
                    genderPolicy: data.houseInfo.genderPolicy,
                    contractTerm: "\(data.houseInfo.contractTerm)개월 이상 계약"
                )
            }
            .eraseToAnyPublisher()
        
        let roomMoodInfo = houseDetailDataSubject
            .compactMap { $0 }
            .map { data in
                RoomMoodInfo(
                    roomMood: data.houseInfo.roomMood,
                    moodTags: data.houseInfo.moodTags,
                    groundRule: data.houseInfo.groundRule
                )
            }
            .eraseToAnyPublisher()
        
        houseDetailDataSubject
            .compactMap { data in
                data?.rooms.map {
                    RoomInfo(
                        roomID: $0.roomID,
                        status: $0.status,
                        name: $0.name,
                        roomType: "\($0.occupancyType)인실 · \($0.gender)",
                        deposit: String.formattedWonString(from: $0.deposit),
                        prepaidUtilities: String.formattedWonString(from: $0.prepaidUtilities),
                        monthlyRent: String.formattedWonString(from: $0.monthlyRent),
                        contractPeriod: $0.contractPeriod ?? "-",
                        managementFee: $0.managementFee
                    )
                }
            }
            .sink { [weak self] roomInfos in
                guard let self else { return }
                self.roomInfos = roomInfos
            }
            .store(in: cancelBag)
        
        houseDetailDataSubject
            .compactMap { data in
                data?.roommates.map {
                    RoommateInfo(
                        age: $0.age,
                        job: $0.job,
                        mbti: $0.mbti,
                        name: $0.name,
                        sleepTime: $0.sleepTime,
                        activityTime: $0.activityTime
                    )
                }
            }
            .sink { [weak self] roommateInfos in
                guard let self else { return }
                self.roommateInfos = roommateInfos
            }
            .store(in: cancelBag)
        
        let safetyLivingFacilityInfo = houseDetailDataSubject
            .compactMap { $0 }
            .map { data in
                data.houseInfo.safetyLivingFacility
            }
            .eraseToAnyPublisher()
        
        let kitchenFacilityInfo = houseDetailDataSubject
            .compactMap { $0 }
            .map { data in
                data.houseInfo.kitchenFacility
            }
            .eraseToAnyPublisher()

        houseDetailDataSubject
            .compactMap { data in
                data?.roommates.map {
                    RoommateInfo(
                        age: $0.age,
                        job: $0.job,
                        mbti: $0.mbti,
                        name: $0.name,
                        sleepTime: $0.sleepTime,
                        activityTime: $0.activityTime
                    )
                }
            }
            .sink { [weak self] roommateInfos in
                guard let self else { return }
                self.roommateInfos = roommateInfos
            }
            .store(in: cancelBag)
        
        let isTourApplyButtonEnabled = self.roomIDSubject
            .map { _ in true }
            .eraseToAnyPublisher()
        
        return Output(
            navigationBarTitle: navigationBarTitle,
            houseMainInfo: houseMainInfo,
            roomMoodInfo: roomMoodInfo,
            safetyLivingFacilityInfo: safetyLivingFacilityInfo,
            kitchenFacilityInfo: kitchenFacilityInfo,
            isTourApplyButtonEnabled: isTourApplyButtonEnabled
        )
    }
}

private extension HouseDetailViewModel {
    func fetchHouseDetailData(houseID: Int) {
        Task {
            do {
                guard let responseBody = try await service.fetchHouseDetailData(houseID: houseID),
                      let data = responseBody.data else { return }
                houseDetailDataSubject.send(data)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
