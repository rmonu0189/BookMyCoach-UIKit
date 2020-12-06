//
//  BookCoachUseCase.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/6/20.
//

import Foundation

protocol BookCoachUseCaseProtocol {
    func bookCoach(coachId: Int, handler: @escaping (Booking?, Error?)-> ())
}

class BookCoachUseCase: BookCoachUseCaseProtocol {
    
    let repository: BookCoachRepositoryProtocol
    
    init(repository: BookCoachRepositoryProtocol) {
        self.repository = repository
    }
    
    func bookCoach(coachId: Int, handler: @escaping (Booking?, Error?)-> ()) {
        repository.bookCoach(coachId: coachId, handler: handler)
    }
    
}
