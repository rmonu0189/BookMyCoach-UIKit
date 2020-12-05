//
//  UserLoginRequest.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 11/29/20.
//

import Foundation

struct UserLoginRequest: Codable {
    var email: String
    var password: String
}

struct UserRegisterRequest: Codable {
    var email: String
    var password: String
    var userType: UserType
}

struct UserUpdateRequest: Codable {
    var fullName: String
    var bio: String?
    var price: Double?
    var latitude: Double?
    var longitude: Double?
    var profilePhoto: String?
}

struct UpdatePasswordRequest: Codable {
    var oldPassword: String
    var newPassword: String
}
