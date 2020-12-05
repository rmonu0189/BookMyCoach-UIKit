//
//  LoginRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol LoginRepositoryProtocol {
    func login(email: String, password: String, handler: @escaping (User?, Error?) -> ())
}
