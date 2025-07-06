//
//  MyAccountService.swift
//  Roomie
//
//  Created by 예삐 on 6/26/25.
//

import Foundation

import Moya

final class MyAccountService {
    let provider: MoyaProvider<MyAccountTargetType>
    
    init(provider: MoyaProvider<MyAccountTargetType> = MoyaProvider(
        session: Session(interceptor: Interceptor.shared),
        plugins: [MoyaLoggingPlugin()])
    ) {
        self.provider = provider
    }
    
    func request<T: ResponseModelType>(
        with request: MyAccountTargetType
    ) async throws -> BaseResponseBody<T>? {
        return try await withCheckedThrowingContinuation {
            continuation in provider.request(request) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(
                            BaseResponseBody<T>.self, from: response.data
                        )
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

extension MyAccountService: MyAccountServiceProtocol {
    func fetchMyAccountData() async throws -> BaseResponseBody<MyAccountResponseDTO>? {
        return try await self.request(with: .fetchMyAccountData)
    }
    
    func updateNameData(request: NameRequestDTO) async throws -> BaseResponseBody<NameResponseDTO>? {
        return try await self.request(with: .updateNameData(request: request))
    }
    
    func updateNicknameData(request: NicknameRequestDTO) async throws -> BaseResponseBody<NicknameResponseDTO>? {
        return try await self.request(with: .updateNicknameData(request: request))
    }
    
    func updateBirthDateData(request: BirthDateRequestDTO) async throws -> BaseResponseBody<BirthDateResponseDTO>? {
        return try await self.request(with: .updateBirthDateData(request: request))
    }
    
    func updatePhoneNumberData(request: PhoneNumberRequestDTO) async throws -> BaseResponseBody<PhoneNumberResponseDTO>? {
        return try await self.request(with: .updatePhoneNumberData(request: request))
    }
    
    func updateGenderData(request: GenderRequestDTO) async throws -> BaseResponseBody<GenderResponseDTO>? {
        return try await self.request(with: .updateGenderData(request: request))
    }
    
    func authLogout(refreshToken: String) async throws -> BaseResponseBody<EmptyModel>? {
        return try await self.request(with: .authLogout(refreshToken: refreshToken))
    }
    
    func authSignout(refreshToken: String) async throws -> BaseResponseBody<EmptyModel>? {
        return try await self.request(with: .authSignout(refreshToken: refreshToken))
    }
}

final class MockMyAccountService: MyAccountServiceProtocol {
    func fetchMyAccountData() async throws -> BaseResponseBody<MyAccountResponseDTO>? {
        let mockData = MyAccountResponseDTO(
            nickname: "카드값줘체리",
            socialType: "KAKAO",
            name: "김루미",
            birthDate: "2025-06-06",
            phoneNumber: "010-1234-5678",
            gender: "여성"
        )
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func updateNameData(request: NameRequestDTO) async throws -> BaseResponseBody<NameResponseDTO>? {
        let mockData = NameResponseDTO(name: "루미")
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func updateNicknameData(request: NicknameRequestDTO) async throws -> BaseResponseBody<NicknameResponseDTO>? {
        let mockData = NicknameResponseDTO(nickname: "야옹")
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func updateBirthDateData(request: BirthDateRequestDTO) async throws -> BaseResponseBody<BirthDateResponseDTO>? {
        let mockData = BirthDateResponseDTO(birthDate: "2025-06-27")
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func updatePhoneNumberData(request: PhoneNumberRequestDTO) async throws -> BaseResponseBody<PhoneNumberResponseDTO>? {
        let mockData = PhoneNumberResponseDTO(phoneNumber: "010-1234-1234")
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func updateGenderData(request: GenderRequestDTO) async throws -> BaseResponseBody<GenderResponseDTO>? {
        let mockData = GenderResponseDTO(gender: "여성")
        return BaseResponseBody(code: 200, message: "", data: mockData)
    }
    
    func authLogout(refreshToken: String) async throws -> BaseResponseBody<EmptyModel>? {
        TokenManager.shared.clearTokens()
        return BaseResponseBody(code: 20012, message: "로그아웃 성공", data: nil)
    }
    
    func authSignout(refreshToken: String) async throws -> BaseResponseBody<EmptyModel>? {
        TokenManager.shared.clearTokens()
        return BaseResponseBody(code: 20013, message: "회원 탈퇴 성공", data: nil)
    }
}
