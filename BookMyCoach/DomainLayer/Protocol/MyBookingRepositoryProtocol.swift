//
//  MyBookingRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol MyBookingRepositoryProtocol {
    func fetchMyBookings(handler: @escaping ([Booking], Error?) -> ())
}
