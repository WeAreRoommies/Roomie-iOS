//
//  MapRequestModelBuilder.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

import Foundation

extension MapRequestDTO {
    final class Builder {
        static let shared = MapRequestDTO.Builder()
        
        private var location: String? = nil
        private var moodTag: [String] = []
        private var depositRange: MinMaxRange = MinMaxRange(min: 0, max: 500)
        private var monthlyRentRange: MinMaxRange = MinMaxRange(min: 0, max: 150)
        private var genderPolicy: [String] = []
        private var preferredDate: String? = nil
        private var occupancyTypes: [String] = []
        private var contractPeroid: [Int] = []
        private var excludeFull: Bool = false
        
        @discardableResult
        func setLocation(_ location: String?) -> Self {
            self.location = location
            return self
        }
        
        @discardableResult
        func setMoodTag(_ moodTag: [String]) -> Self {
            self.moodTag = moodTag
            return self
        }
        
        @discardableResult
        func setDepositRange(_ depositRange: MinMaxRange) -> Self {
            self.depositRange = depositRange
            return self
        }
        
        @discardableResult
        func setMonthlyRentRange(_ monthlyRentRange: MinMaxRange) -> Self {
            self.monthlyRentRange = monthlyRentRange
            return self
        }
        
        @discardableResult
        func setGenderPolicy(_ genderPolicy: [String]) -> Self {
            self.genderPolicy = genderPolicy
            return self
        }
        
        @discardableResult
        func setOccupancyTypes(_ occupancyTypes: [String]) -> Self {
            self.occupancyTypes = occupancyTypes
            return self
        }
        
        @discardableResult
        func setPreferredDate(_ preferredDate: String?) -> Self {
            self.preferredDate = preferredDate
            return self
        }
        
        @discardableResult
        func setContractPeroid(_ contractPeriod: [Int]) -> Self {
            self.contractPeroid = contractPeriod
            return self
        }
        
        func build() -> MapRequestDTO {
            return MapRequestDTO(
                location: location,
                moodTag: moodTag,
                depositRange: depositRange,
                monthlyRentRange: monthlyRentRange,
                genderPolicy: genderPolicy,
                preferredDate: preferredDate,
                occupancyTypes: occupancyTypes,
                contractPeriod: contractPeroid,
                excludeFull: excludeFull
            )
        }
    }
}
