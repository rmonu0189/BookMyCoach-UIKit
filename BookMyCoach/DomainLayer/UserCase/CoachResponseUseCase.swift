//
//  CoachResponseUseCase.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/6/20.
//

import Foundation

protocol CoachResponseUseCaseProtocol {
    func respondToBookingRequest(bookingId: Int, isAccept: Bool, handler: @escaping (Bool, Error?) -> ())
}

class CoachResponseUseCase: CoachResponseUseCaseProtocol {
    
    let repository: CoachRespondRepositoryProtocol
    
    init(repository: CoachRespondRepositoryProtocol) {
        self.repository = repository
    }
    
    func respondToBookingRequest(bookingId: Int, isAccept: Bool, handler: @escaping (Bool, Error?) -> ()) {
        repository.responseBookingRequest(bookingId: bookingId, isAccept: isAccept, handler: handler)
    }
}
