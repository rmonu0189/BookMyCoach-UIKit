//
//  CoachRespondRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/6/20.
//

import Foundation

protocol CoachRespondRepositoryProtocol {
    func responseBookingRequest(bookingId: Int, isAccept: Bool, handler: @escaping (Bool, Error?) -> ())
}

