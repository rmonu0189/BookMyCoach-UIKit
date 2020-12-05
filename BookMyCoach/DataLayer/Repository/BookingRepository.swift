//
//  BookingRepository.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

class BookingRepository: MyBookingRepositoryProtocol, CoachPendingInvitationRepositoryProtocol {
    
    func fetchMyBookings(handler: @escaping ([Booking], Error?) -> ()) {
        let service = APIService.getMyBookings
        service.fetchList(Booking.self) { (list, error, _) in
            handler(list ?? [], error)
        }
    }
    
    func getPendingBookingRequestForCoach(handler: @escaping ([Booking], Error?) -> ()) {
        let service = APIService.pendingRequestForCoach
        service.fetchList(Booking.self) { (list, error, _) in
            handler(list ?? [], error)
        }
    }
    
    func responseBookingRequest(bookingId: Int, isAccept: Bool, handler: @escaping (Bool, Error?) -> ()) {
        let service = APIService.acceptBookingRequest(request: RespondBookingRequest(bookingId: bookingId, isAccepted: isAccept))
        service.submit { (response) in
            handler(response.isSuccess, response.error)
        }
    }
    
}
