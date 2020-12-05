//
//  Sport.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 24/11/20.
//

import Foundation

struct UserSport: Codable {
    var id: Int
    var sport: Sport?
}

struct Sport: Codable, Hashable {
    var id: Int
    var name: String
    var icon: String
}
