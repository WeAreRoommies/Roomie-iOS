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
        
        private var address: String? = nil
        var moodTag: [String] = []
        var depositRange: MinMaxRange = MinMaxRange(min: 0, max: 500)
        var monthlyRentRange: MinMaxRange = MinMaxRange(min: 0, max: 150)
        var genderPolicy: [String] = []
        var preferredDate: String? = nil
        var occupancyTypes: [String] = []
        var contractPeriod: [Int] = []
        var latitude: Double = 0
        var longitude: Double = 0
        
        @discardableResult
        func setAddress(_ address: String?) -> Self {
            self.address = address
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
        func setContractPeriod(_ contractPeriod: [Int]) -> Self {
            self.contractPeriod = contractPeriod
            return self
        }
        
        @discardableResult
        func setLatitude(_ latitude: Double) -> Self {
            self.latitude = latitude
            return self
        }
        
        @discardableResult
        func setLongitude(_ longitude: Double) -> Self {
            self.longitude = longitude
            return self
        }
        
        func build() -> MapRequestDTO {
            return MapRequestDTO(
                address: address,
                moodTag: moodTag,
                depositRange: depositRange,
                monthlyRentRange: monthlyRentRange,
                genderPolicy: genderPolicy,
                preferredDate: preferredDate,
                occupancyTypes: occupancyTypes,
                contractPeriod: contractPeriod,
                latitude: latitude,
                longitude: longitude
            )
        }
    }
}
