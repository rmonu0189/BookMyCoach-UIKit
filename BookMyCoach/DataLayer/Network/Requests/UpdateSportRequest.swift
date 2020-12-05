//
//  SportRequest.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

struct UpdateSportRequest: Codable {
    
    var sports: [UpdateSportRequest.Sport]
    
    struct Sport: Codable {
        var sportId: Int
        var isPrimary: Bool
    }
}
