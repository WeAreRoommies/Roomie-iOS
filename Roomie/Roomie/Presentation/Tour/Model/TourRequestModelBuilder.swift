//
//  TourRequestModelBuilder.swift
//  Roomie
//
//  Created by 김승원 on 1/24/25.
//

import Foundation

extension TourRequestDTO {
    final class Builder {
        static let shared = TourRequestDTO.Builder()
        private init() {}
        
        private var name: String = ""
        private var birth: String = ""
        private var gender: String = ""
        private var phoneNumber: String = ""
        private var preferredDate: String = ""
        private var message: String = ""
        private var roomID = 0
        private var houseID = 0
        
        @discardableResult
        func setName(_ name: String) -> Self {
            self.name = name
            return self
        }
        
        @discardableResult
        func setBirth(_ birth: String) -> Self {
            self.birth = birth
            return self
        }
        
        @discardableResult
        func setGender(_ gender: String) -> Self {
            self.gender = gender
            return self
        }
        
        @discardableResult
        func setPhoneNumber(_ phoneNumber: String) -> Self {
            self.phoneNumber = phoneNumber
            return self
        }
        
        @discardableResult
        func setPreferredDate(_ preferredDate: String) -> Self {
            self.preferredDate = preferredDate
            return self
        }
        
        @discardableResult
        func setMessage(_ message: String) -> Self {
            self.message = message
            return self
        }
        
        @discardableResult
        func setRoomID(_ roomID: Int) -> Self {
            self.roomID = roomID
            return self
        }
        
        @discardableResult
        func setHouseID(_ houseID: Int) -> Self {
            self.houseID = houseID
            return self
        }
        
        func build() -> TourRequestDTO {
            return TourRequestDTO(
                name: name,
                birth: birth,
                gender: gender,
                phoneNumber: phoneNumber,
                preferredDate: preferredDate,
                message: message,
                roomID: roomID,
                houseID: houseID
            )
        }
    }
}
