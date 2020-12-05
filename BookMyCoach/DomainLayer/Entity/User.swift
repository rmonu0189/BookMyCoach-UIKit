//
//  User.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 11/23/20.
//

import Foundation

struct User: Codable {
    var id: Int
    var fullName: String?
    var email: String
    var profilePhoto: String?
    var bio: String?
    var latitude: Double?
    var longitude: Double?
    var price: Double?
    var userType: UserType = UserType.player
    var userSports: [UserSport]?
    var rating: Float? = 0.0
    var isProfileComplete: Bool? = false
    var bookings: [Booking]? = []
    
    var bookingStatus: Booking.BookingStatus {
        let myBooking = bookings?.filter({$0.userId == UserManager.shared.activeUser?.id}).first
        if let status = Booking.BookingStatus(rawValue: myBooking?.status.rawValue ?? "none") {
            return status
        }
        return .none
    }
    
    init() {
        id = 0
        email = ""
    }

    init(id: Int, fullName: String?, email: String, profilePhoto: String?, bio: String?, latitude: Double?, longitude: Double?, price: Double?, userType: UserType, sport: [Sport]?, rating: Float?) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.profilePhoto = profilePhoto
        self.bio = bio
        self.latitude = latitude
        self.longitude = longitude
        self.price = price
        self.userType = userType
        self.userSports = sport?.compactMap{UserSport(id: 0, sport: $0)}
        self.rating = rating
    }

}

enum UserType: String, Codable {
    case coach
    case player
}
