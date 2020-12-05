//
//  CoachPendingInvitationUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 06/12/20.
//

import Foundation

protocol CoachPendingInvitationUseCaseProtocol {
    func pendingInvitationForCoach(handler: @escaping ([Booking], Error?) -> ())
}

class CoachPendingInvitationUseCase: CoachPendingInvitationUseCaseProtocol {
    
    private let repository: CoachPendingInvitationRepositoryProtocol
    
    init(repository: CoachPendingInvitationRepositoryProtocol) {
        self.repository = repository
    }
    
    func pendingInvitationForCoach(handler: @escaping ([Booking], Error?) -> ()) {
        repository.getPendingBookingRequestForCoach(handler: handler)
    }
    
}
