//
//  SportListRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol SportListRepositoryProtocol {
    func fetchSportList(handler: @escaping ([Sport]?, Error?) -> ())
}
