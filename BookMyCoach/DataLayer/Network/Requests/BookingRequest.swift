//
//  BookingRequest.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/2/20.
//

import Foundation

struct BookCoachRequest: Codable {
    let coachId: Int
}

struct RespondBookingRequest: Codable {
    let bookingId: Int
    let isAccepted: Bool
}
