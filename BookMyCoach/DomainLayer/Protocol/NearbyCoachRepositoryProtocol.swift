//
//  NearbyCoachRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol NearbyCoachRepositoryProtocol {
    func nearbyCoach(_ request: NearbyCoachRequest, handler: @escaping ([User]?, Error?) -> ())
}
