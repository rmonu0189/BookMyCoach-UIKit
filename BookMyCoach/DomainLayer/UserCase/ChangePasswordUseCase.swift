//
//  ChangePasswordUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 06/12/20.
//

import Foundation

protocol ChangePasswordUseCaseProtocol {
    func changePassword(oldPassword: String, newPassword: String, handler: @escaping (Bool, Error?)-> ())
}

class ChangePasswordUseCase: ChangePasswordUseCaseProtocol {
    
    var repository: ChangePasswordRepositoryProtocol
    
    init(repository: ChangePasswordRepositoryProtocol) {
        self.repository = repository
    }
    
    func changePassword(oldPassword: String, newPassword: String, handler: @escaping (Bool, Error?)-> ()) {
        repository.changePassword(oldPassword: oldPassword, newPassword: newPassword, handler: handler)
    }
    
}
