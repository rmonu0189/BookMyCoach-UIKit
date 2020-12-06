//
//  ChangePasswordRepositoryProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 06/12/20.
//

import Foundation

protocol ChangePasswordRepositoryProtocol {
    func changePassword(oldPassword: String, newPassword: String, handler: @escaping (Bool, Error?)-> ())
}
