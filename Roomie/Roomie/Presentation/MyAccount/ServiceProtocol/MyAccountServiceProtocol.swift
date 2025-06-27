//
//  MyAccountServiceProtocol.swift
//  Roomie
//
//  Created by 예삐 on 6/26/25.
//

import Foundation

protocol MyAccountServiceProtocol {
    func fetchMyAccountData() async throws -> BaseResponseBody<MyAccountResponseDTO>?
    func updateNameData(request: NameRequestDTO) async throws -> BaseResponseBody<NameResponseDTO>?
    func updateNicknameData(request: NicknameRequestDTO) async throws -> BaseResponseBody<NicknameResponseDTO>?
    func updateBirthDateData(request: BirthDateRequestDTO) async throws -> BaseResponseBody<BirthDateResponseDTO>?
    func updatePhoneNumberData(request: PhoneNumberRequestDTO) async throws -> BaseResponseBody<PhoneNumberResponseDTO>?
    func updateGenderData(request: GenderRequestDTO) async throws -> BaseResponseBody<GenderResponseDTO>?
}
