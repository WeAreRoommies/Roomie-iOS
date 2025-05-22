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
    
    private let radioButtonSubject = PassthroughSubject<Void, Never>()
    private let pinnedInfoSubject = PassthroughSubject<Bool, Never>()
    
    private var buttonIndex: Int = 0
    
    private(set) var houseID: Int = 0
    
    @Published var houseName: String = ""
    @Published var roomName: String = ""
    
    @Published private(set) var roomInfos: [RoomInfo] = []
    
    // MARK: - Initializer
    
    init(houseID: Int, service: HouseDetailServiceProtocol) {
        self.houseID = houseID
        self.service = service
    }
}

extension HouseDetailViewModel: ViewModelType {
    struct Input {
        let houseDetailViewWillAppear: AnyPublisher<Void, Never>
        let bottomSheetViewWillAppear: AnyPublisher<Void, Never>
        let buttonIndexSubject: AnyPublisher<Int, Never>
        let tourApplyButtonTapSubject: AnyPublisher<Void, Never>
        let wishListButtonSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let navigationBarTitle: AnyPublisher<String, Never>
        let houseMainInfo: AnyPublisher<HouseMainInfo, Never>
        let roomMoodInfo: AnyPublisher<RoomMoodInfo, Never>
        let safetyLivingFacilityInfo: AnyPublisher<[String], Never>
        let kitchenFacilityInfo: AnyPublisher<[String], Never>
        let isTourApplyButtonEnabled: AnyPublisher<Bool, Never>
        let roomButtonInfos: AnyPublisher<[RoomButtonInfo], Never>
        let selectedRoomID: AnyPublisher<SelectedRoomInfo, Never>
        let pinnedInfo: AnyPublisher<Bool, Never>
        let pinnedStatus: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.houseDetailViewWillAppear
            .sink { [weak self] in
                guard let self else { return }
            
                self.fetchHouseDetailData(houseID: self.houseID)
            }
            .store(in: cancelBag)
        
        input.buttonIndexSubject
            .sink { [weak self] roomID in
                guard let self else { return }
                self.radioButtonSubject.send(())
                self.buttonIndex = roomID
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
        
        let isTourApplyButtonEnabled = radioButtonSubject
            .map { _ in true }
            .eraseToAnyPublisher()
        
        let roomButtonInfos = input.bottomSheetViewWillAppear
            .compactMap { _ in
                self.houseDetailDataSubject.value?.rooms.map {
                    RoomButtonInfo(
                        name: $0.name,
                        status: $0.status,
                        isTourAvailable: $0.isTourAvailable,
                        subTitle: "\($0.deposit / 10000)/\($0.monthlyRent / 10000)"
                    )
                }
            }
            .eraseToAnyPublisher()
        
        let selectedRoomID = input.tourApplyButtonTapSubject
            .map { [weak self] _ -> SelectedRoomInfo? in
                guard let self = self,
                      let houseDetailData = self.houseDetailDataSubject.value else {
                    return nil
                }
                
                return SelectedRoomInfo(
                    houseID: self.houseID,
                    roomID: houseDetailData.rooms[buttonIndex].roomID,
                    houseName: houseDetailData.houseInfo.name,
                    roomName: houseDetailData.rooms[buttonIndex].name
                )
            }
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        input.wishListButtonSubject
            .sink { [weak self] in
                guard let self else { return }
                self.updatePinnedHouse(houseID: houseID)
            }
            .store(in: cancelBag)
        
        let pinnedInfo = pinnedInfoSubject
            .eraseToAnyPublisher()
        
        let pinnedStatus = houseDetailDataSubject
            .compactMap { $0 }
            .map { data in
                data.houseInfo.isPinned
            }
            .eraseToAnyPublisher()
        
        return Output(
            navigationBarTitle: navigationBarTitle,
            houseMainInfo: houseMainInfo,
            roomMoodInfo: roomMoodInfo,
            safetyLivingFacilityInfo: safetyLivingFacilityInfo,
            kitchenFacilityInfo: kitchenFacilityInfo,
            isTourApplyButtonEnabled: isTourApplyButtonEnabled,
            roomButtonInfos: roomButtonInfos,
            selectedRoomID: selectedRoomID,
            pinnedInfo: pinnedInfo,
            pinnedStatus: pinnedStatus
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
                self.houseName = data.houseInfo.name
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
                pinnedInfoSubject.send(data.isPinned)
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
