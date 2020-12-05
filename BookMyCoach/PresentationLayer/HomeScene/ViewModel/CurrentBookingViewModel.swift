//
//  CurrentBookingViewModel.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/5/20.
//

import Foundation

protocol  CurrentBookingViewModelOutput {
    var avtarImageURL: String { get set }
    var coachName: String { get set }
    var sportName: String { get set }
    var rating: String { get set }
    var bookingStatus: String { get set }
    var bookingDate: String { get set }
    var sessionTime: String { get set }
}

protocol CurrentBookingViewModelInput {}

protocol CurrentBookingViewModelProtocol: CurrentBookingViewModelInput, CurrentBookingViewModelOutput { }

class CurrentBookingViewModel: CurrentBookingViewModelProtocol {
    
    var avtarImageURL: String = ""
    var coachName: String = ""
    var sportName: String = ""
    var rating: String = ""
    var bookingStatus: String = ""
    var bookingDate: String = ""
    var sessionTime: String = ""
        
    init(_ booking: Booking) {
        if UserManager.shared.activeUser?.userType == UserType.player {
            self.avtarImageURL = booking.coach?.profilePhoto ?? ""
            self.coachName = booking.coach?.fullName ?? ""
            self.sportName = booking.coach?.userSports?.first?.sport?.name ?? ""
        } else {
            self.avtarImageURL = booking.user?.profilePhoto ?? ""
            self.coachName = booking.user?.fullName ?? ""
            self.sportName = ""
        }
        
        self.rating = booking.coach?.rating?.description ?? "5.0"
        self.bookingStatus = booking.status.rawValue.capitalized
        self.bookingDate = booking.createdAt?.formatted(Date.Format.yyyyMMddhhmma) ?? ""
        self.sessionTime = booking.sessionStartDateTime?.formatted(Date.Format.hhmma) ?? ""
    }
    
}

