//
//  BookCoachRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/6/20.
//

import Foundation

protocol BookCoachRepositoryProtocol {
    func bookCoach(coachId: Int, handler: @escaping (Booking?, Error?)-> ())
}
