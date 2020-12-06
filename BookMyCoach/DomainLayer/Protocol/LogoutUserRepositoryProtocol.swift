//
//  LogoutUserRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 06/12/20.
//

import Foundation

protocol LogoutUserRepositoryProtocol {
    func logout(_ handler: @escaping (Bool, Error?)-> ())
}
