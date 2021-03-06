//
//  PendingBookingCellViewModel.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 06/12/20.
//

import Foundation

protocol PendingBookingCellViewModelInput {
    var bookingId: Int { get set }
}

protocol PendingBookingCellViewModelOutput {
    var userName: String { get }
    var sessionDateTime: String { get }
    var profileIcon: String { get }
}

protocol PendingBookingCellViewModelProtocol: PendingBookingCellViewModelInput, PendingBookingCellViewModelOutput { }

class PendingBookingCellViewModel: PendingBookingCellViewModelProtocol {
    
    var userName: String = ""
    var sessionDateTime: String = ""
    var profileIcon: String = ""
    var bookingId = 0
    
    init(_ booking: Booking) {
        userName = booking.user?.fullName ?? ""
        sessionDateTime = booking.sessionStartDateTime?.formatted(Date.Format.yyyyMMddhhmma) ?? ""
        profileIcon = booking.user?.profilePhoto ?? ""
        bookingId = booking.id
    }
    
}
