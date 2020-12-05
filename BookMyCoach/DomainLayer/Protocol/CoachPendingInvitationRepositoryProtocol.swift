//
//  CoachPendingInvitationRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol CoachPendingInvitationRepositoryProtocol {
    func getPendingBookingRequestForCoach(handler: @escaping ([Booking], Error?) -> ())
}
