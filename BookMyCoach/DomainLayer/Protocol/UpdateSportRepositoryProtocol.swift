//
//  UpdateSportRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol UpdateSportRepositoryProtocol {
    func updateSport(sportId: Int, isPrimary: Bool, handler: @escaping (User?, Error?) -> ())
}
