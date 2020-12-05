//
//  UpdateUserRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol UpdateUserRepositoryProtocol {
    func updateUser(request: UserUpdateRequest, handler: @escaping (User?, Error?) -> ())
}
