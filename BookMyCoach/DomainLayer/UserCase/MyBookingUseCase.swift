//
//  MyBookingUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol MyBookingUseCaseProtocol {
    func fetchMyBookings(handler: @escaping ([Booking], Error?) -> ())
}

class MyBookingUseCase: MyBookingUseCaseProtocol {
    
    private let repository: MyBookingRepositoryProtocol
    
    init(repository: MyBookingRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchMyBookings(handler: @escaping ([Booking], Error?) -> ()) {
        repository.fetchMyBookings(handler: handler)
    }
    
}
