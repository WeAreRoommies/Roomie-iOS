//
//  MapFilterViewModel.swift
//  Roomie
//
//  Created by 예삐 on 1/12/25.
//

import Foundation
import Combine

final class MapFilterViewModel {
    private let builder: MapRequestDTO.Builder
    
    private let depositMaxValue: Int = 500
    private let monthlyRentMaxValue: Int = 150
    
    private let depositMinSubject = CurrentValueSubject<Int, Never>(0)
    private let depositMaxSubject = CurrentValueSubject<Int, Never>(500)
    
    private let monthlyRentMinSubject = CurrentValueSubject<Int, Never>(0)
    private let monthlyRentMaxSubject = CurrentValueSubject<Int, Never>(150)
    
    private let genderSubject = CurrentValueSubject<[String], Never>([])
    private let occupancyTypeSubject = CurrentValueSubject<[String], Never>([])
    private let moodTagSubject = CurrentValueSubject<[String], Never>([])
    
    private let preferredDateSubject = CurrentValueSubject<String?, Never>(nil)
    private let contractPeriodSubject = CurrentValueSubject<[Int], Never>([])
    
    init(builder: MapRequestDTO.Builder) {
        self.builder = builder
    }
}

extension MapFilterViewModel: ViewModelType {
    struct Input {
        /// 보증금 텍스트필드 값
        let depositMinText: AnyPublisher<Int, Never>
        let depositMaxText: AnyPublisher<Int, Never>
        
        /// 월세 텍스트필드 값
        let monthlyRentMinText: AnyPublisher<Int, Never>
        let monthlyRentMaxText: AnyPublisher<Int, Never>
        
        /// 성별 옵션
        let maleButtonDidTap: AnyPublisher<Void, Never>
        let femaleButtonDidTap: AnyPublisher<Void, Never>
        let genderDivisionButtonDidTap: AnyPublisher<Void, Never>
        let genderFreeButtonDidTap: AnyPublisher<Void, Never>
        
        /// 방 형태 옵션
        let singleButtonDidTap: AnyPublisher<Void, Never>
        let doubleButtonDidTap: AnyPublisher<Void, Never>
        let tripleButtonDidTap: AnyPublisher<Void, Never>
        let quadButtonDidTap: AnyPublisher<Void, Never>
        
        /// 분위기 옵션
        let calmButtonDidTap: AnyPublisher<Void, Never>
        let livelyButtonDidTap: AnyPublisher<Void, Never>
        let neatButtonDidTap: AnyPublisher<Void, Never>
        
        /// 계약기간 옵션
        let preferredDate: AnyPublisher<String?, Never>
        let threeMonthButtonDidTap: AnyPublisher<Void, Never>
        let sixMonthButtonDidTap: AnyPublisher<Void, Never>
        let oneYearButtonDidTap: AnyPublisher<Void, Never>
        
        /// 초기화 및 적용 버튼
        let resetButtonDidTap: AnyPublisher<Void, Never>
        let applyButtonDidTap: AnyPublisher<Void, Never>
    }
    
    struct Output {
        /// 보증금 텍스트필드 값
        let depositMinText: AnyPublisher<Int, Never>
        let depositMaxText: AnyPublisher<Int, Never>
        
        /// 월세 텍스트필드 값
        let monthlyRentMinText: AnyPublisher<Int, Never>
        let monthlyRentMaxText: AnyPublisher<Int, Never>
        
        /// 방 형태
        let isGenderEmpty: AnyPublisher<Bool, Never>
        let isOccupancyTypeEmpty: AnyPublisher<Bool, Never>
        let isMoodTagEmpty: AnyPublisher<Bool, Never>
        
        /// 계약기간
        let isPreferredDateEmpty: AnyPublisher<Bool, Never>
        let isContractPeriodEmpty: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.depositMinText
            .map { $0 > self.depositMaxValue ? self.depositMaxValue : $0 }
            .sink { [weak self] depositMin in
                guard let self = self else { return }
                if depositMin > depositMaxSubject.value {
                    self.depositMinSubject.send(depositMaxSubject.value)
                    self.depositMaxSubject.send(depositMin)
                } else {
                    self.depositMinSubject.send(depositMin)
                }
            }
            .store(in: cancelBag)
        
        input.depositMaxText
            .map { $0 > self.depositMaxValue ? self.depositMaxValue : $0 }
            .sink { [weak self] depositMax in
                guard let self = self else { return }
                if depositMax < depositMinSubject.value {
                    self.depositMaxSubject.send(depositMinSubject.value)
                    self.depositMinSubject.send(depositMax)
                } else {
                    self.depositMaxSubject.send(depositMax)
                }
            }
            .store(in: cancelBag)
        
        input.monthlyRentMinText
            .map { $0 > self.monthlyRentMaxValue ? self.monthlyRentMaxValue : $0 }
            .sink { [weak self] monthlyRentMin in
                guard let self = self else { return }
                if monthlyRentMin > monthlyRentMaxSubject.value {
                    self.monthlyRentMinSubject.send(monthlyRentMaxSubject.value)
                    self.monthlyRentMaxSubject.send(monthlyRentMin)
                } else {
                    self.monthlyRentMinSubject.send(monthlyRentMin)
                }
            }
            .store(in: cancelBag)
        
        input.monthlyRentMaxText
            .map { $0 > self.monthlyRentMaxValue ? self.monthlyRentMaxValue : $0 }
            .sink { [weak self] monthlyRentMax in
                guard let self = self else { return }
                if monthlyRentMax < monthlyRentMinSubject.value {
                    self.monthlyRentMaxSubject.send(monthlyRentMinSubject.value)
                    self.monthlyRentMinSubject.send(monthlyRentMax)
                } else {
                    self.monthlyRentMaxSubject.send(monthlyRentMax)
                }
            }
            .store(in: cancelBag)
        
        input.maleButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let gender = "남성전용"
                
                self.genderSubject.send(
                    self.genderSubject.value.contains(gender)
                    ? self.genderSubject.value.filter { $0 != gender }
                    : self.genderSubject.value + [gender]
                )
            }
            .store(in: cancelBag)
        
        input.femaleButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let gender = "여성전용"
                
                self.genderSubject.send(
                    self.genderSubject.value.contains(gender)
                    ? self.genderSubject.value.filter { $0 != gender }
                    : self.genderSubject.value + [gender]
                )
            }
            .store(in: cancelBag)
        
        input.genderDivisionButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let gender = "남녀분리"
                
                self.genderSubject.send(
                    self.genderSubject.value.contains(gender)
                    ? self.genderSubject.value.filter { $0 != gender }
                    : self.genderSubject.value + [gender]
                )
            }
            .store(in: cancelBag)
        
        input.genderFreeButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let gender = "성별무관"
                
                self.genderSubject.send(
                    self.genderSubject.value.contains(gender)
                    ? self.genderSubject.value.filter { $0 != gender }
                    : self.genderSubject.value + [gender]
                )
            }
            .store(in: cancelBag)
        
        input.singleButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let occupancyType = "1인실"
                
                self.occupancyTypeSubject.send(
                    self.occupancyTypeSubject.value.contains(occupancyType)
                    ? self.occupancyTypeSubject.value.filter { $0 != occupancyType }
                    : self.occupancyTypeSubject.value + [occupancyType]
                )
            }
            .store(in: cancelBag)
        
        input.doubleButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let occupancyType = "2인실"
                
                self.occupancyTypeSubject.send(
                    self.occupancyTypeSubject.value.contains(occupancyType)
                    ? self.occupancyTypeSubject.value.filter { $0 != occupancyType }
                    : self.occupancyTypeSubject.value + [occupancyType]
                )
            }
            .store(in: cancelBag)
        
        input.tripleButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let occupancyType = "3인실"
                
                self.occupancyTypeSubject.send(
                    self.occupancyTypeSubject.value.contains(occupancyType)
                    ? self.occupancyTypeSubject.value.filter { $0 != occupancyType }
                    : self.occupancyTypeSubject.value + [occupancyType]
                )
            }
            .store(in: cancelBag)
        
        input.quadButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let occupancyType = "4인실"
                
                self.occupancyTypeSubject.send(
                    self.occupancyTypeSubject.value.contains(occupancyType)
                    ? self.occupancyTypeSubject.value.filter { $0 != occupancyType }
                    : self.occupancyTypeSubject.value + [occupancyType]
                )
            }
            .store(in: cancelBag)
        
        input.calmButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let moodTag = "#차분한"
                
                self.moodTagSubject.send(
                    self.moodTagSubject.value.contains(moodTag)
                    ? self.moodTagSubject.value.filter { $0 != moodTag }
                    : self.moodTagSubject.value + [moodTag]
                )
            }
            .store(in: cancelBag)
        
        input.livelyButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let moodTag = "#활기찬"
                
                self.moodTagSubject.send(
                    self.moodTagSubject.value.contains(moodTag)
                    ? self.moodTagSubject.value.filter { $0 != moodTag }
                    : self.moodTagSubject.value + [moodTag]
                )
            }
            .store(in: cancelBag)
        
        input.neatButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let moodTag = "#깔끔한"
                
                self.moodTagSubject.send(
                    self.moodTagSubject.value.contains(moodTag)
                    ? self.moodTagSubject.value.filter { $0 != moodTag }
                    : self.moodTagSubject.value + [moodTag]
                )
            }
            .store(in: cancelBag)
        
        input.threeMonthButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let contractPeroid = 3
                
                self.contractPeriodSubject.send(
                    self.contractPeriodSubject.value.contains(contractPeroid)
                    ? self.contractPeriodSubject.value.filter { $0 != contractPeroid }
                    : self.contractPeriodSubject.value + [contractPeroid]
                )
            }
            .store(in: cancelBag)
        
        input.preferredDate
            .compactMap { $0 }
            .compactMap { String.formattedDateString($0) }
            .sink { [weak self] date in
                guard let self = self else { return }
                self.preferredDateSubject.send(date)
            }
            .store(in: cancelBag)
        
        input.sixMonthButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let contractPeroid = 6
                
                self.contractPeriodSubject.send(
                    self.contractPeriodSubject.value.contains(contractPeroid)
                    ? self.contractPeriodSubject.value.filter { $0 != contractPeroid }
                    : self.contractPeriodSubject.value + [contractPeroid]
                )
            }
            .store(in: cancelBag)
        
        input.oneYearButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                let contractPeroid = 12
                
                self.contractPeriodSubject.send(
                    self.contractPeriodSubject.value.contains(contractPeroid)
                    ? self.contractPeriodSubject.value.filter { $0 != contractPeroid }
                    : self.contractPeriodSubject.value + [contractPeroid]
                )
            }
            .store(in: cancelBag)
        
        input.resetButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                self.depositMaxSubject.send(500)
                self.depositMinSubject.send(0)
                self.monthlyRentMaxSubject.send(150)
                self.monthlyRentMinSubject.send(0)
                self.genderSubject.send([])
                self.occupancyTypeSubject.send([])
                self.moodTagSubject.send([])
                self.preferredDateSubject.send("")
                self.contractPeriodSubject.send([])
            }
            .store(in: cancelBag)
        
        input.applyButtonDidTap
            .sink { [weak self] in
                guard let self = self else { return }
                
                self.builder
                    .setDepositRange(
                        MinMaxRange(
                            min: self.depositMinSubject.value,
                            max: self.depositMaxSubject.value
                        )
                    )
                    .setMonthlyRentRange(
                        MinMaxRange(
                            min: self.monthlyRentMinSubject.value,
                            max: self.monthlyRentMaxSubject.value
                        )
                    )
                    .setGenderPolicy(genderSubject.value)
                    .setOccupancyTypes(occupancyTypeSubject.value)
                    .setMoodTag(moodTagSubject.value)
                    .setPreferredDate(preferredDateSubject.value)
                    .setContractPeroid(contractPeriodSubject.value)
            }
            .store(in: cancelBag)
        
        let depositMin = depositMinSubject
            .eraseToAnyPublisher()
        
        let depositMax = depositMaxSubject
            .eraseToAnyPublisher()
        
        let monthlyRentMin = monthlyRentMinSubject
            .eraseToAnyPublisher()
        
        let monthlyRentMax = monthlyRentMaxSubject
            .eraseToAnyPublisher()
        
        let isGenderEmpty = genderSubject
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
        
        let isOccupancyTypeEmpty = occupancyTypeSubject
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
        
        let isMoodTagEmpty = moodTagSubject
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
        
        let isPreferredEmpty = preferredDateSubject
            .map { $0?.isEmpty ?? true }
            .eraseToAnyPublisher()
        
        let isContractPeriodEmpty = contractPeriodSubject
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
        
        return Output(
            depositMinText: depositMin,
            depositMaxText: depositMax,
            monthlyRentMinText: monthlyRentMin,
            monthlyRentMaxText: monthlyRentMax,
            isGenderEmpty: isGenderEmpty,
            isOccupancyTypeEmpty: isOccupancyTypeEmpty,
            isMoodTagEmpty: isMoodTagEmpty,
            isPreferredDateEmpty: isPreferredEmpty,
            isContractPeriodEmpty: isContractPeriodEmpty
        )
    }
}
