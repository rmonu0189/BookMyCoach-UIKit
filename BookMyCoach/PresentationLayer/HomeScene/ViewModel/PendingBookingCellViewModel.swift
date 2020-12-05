//
//  PendingBookingCellViewModel.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 06/12/20.
//

import Foundation

protocol PendingBookingCellViewModelInput {
    
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
    
    init(_ booking: Booking) {
        userName = booking.user?.fullName ?? ""
        sessionDateTime = booking.sessionStartDateTime?.formatted(Date.Format.yyyyMMddhhmma) ?? ""
        profileIcon = booking.user?.profilePhoto ?? ""
    }
    
}
