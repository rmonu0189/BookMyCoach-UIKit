//
//  RegisterRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol RegisterRepositoryProtocol {
    func register(email: String, password: String, userType: UserType, handler: @escaping (User?, Error?) -> ())
}
