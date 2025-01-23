//
//  TourDateViewModel.swift
//  Roomie
//
//  Created by 김승원 on 1/15/25.
//

import Foundation
import Combine

final class TourDateViewModel {
    
    // MARK: - Property
    
    private let roomID: Int
    
    private let service: HouseDetailServiceProtocol
    private let builder: TourRequestDTO.Builder
    
    private let tourResponseData = CurrentValueSubject<TourResponseDTO?, Never>(nil)
    
    private let dateSubject = CurrentValueSubject<String, Never>("")
    private let messageSubject = CurrentValueSubject<String, Never>("")
    
    // MARK: - Initializer
    
    init(service: HouseDetailServiceProtocol, builder: TourRequestDTO.Builder, roomID: Int) {
        self.service = service
        self.builder = builder
        self.roomID = roomID
    }
}

extension TourDateViewModel: ViewModelType {
    struct Input {
        let dateSubject: AnyPublisher<String, Never>
        let messageSubject: AnyPublisher<String, Never>
        let nextButtonSubject: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let isNextButtonEnabled: AnyPublisher<Bool, Never>
        let presentNextView: AnyPublisher<Void, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.nextButtonSubject
            .compactMap { $0 }
            .sink { [weak self] in
                guard let self else { return }
                guard let formattedDateString = String.formattedDateString(self.dateSubject.value) else { return }
                self.builder.setPreferredDate(formattedDateString)
                self.builder.setMessage(messageSubject.value)
                self.applyTour(request: builder.build(), roomID: roomID)
            }
            .store(in: cancelBag)
        
        input.dateSubject
            .sink { [weak self] date in
                self?.dateSubject.send(date)
            }
            .store(in: cancelBag)
        
        input.messageSubject
            .sink { [weak self] message in
                self?.messageSubject.send(message)
            }
            .store(in: cancelBag)
        
        let isNextButtonEnabled = dateSubject
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
        
        return Output(
            isNextButtonEnabled: isNextButtonEnabled,
            presentNextView: input.nextButtonSubject
        )
    }
}

private extension TourDateViewModel {
    func applyTour(request: TourRequestDTO, roomID: Int) {
        Task {
            do {
                guard let responseBody = try await service.applyTour(request: request, roomID: roomID),
                      let data = responseBody.data else { return }
                
            } catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
