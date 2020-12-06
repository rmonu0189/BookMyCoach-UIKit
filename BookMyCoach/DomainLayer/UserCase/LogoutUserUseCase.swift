//
//  LogoutUserUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 06/12/20.
//

import Foundation

protocol LogoutUserUseCaseProtocol {
    func logout(_ handler: @escaping (Bool, Error?)-> ())
}

class LogoutUserUseCase: LogoutUserUseCaseProtocol {
    
    private let repository: LogoutUserRepositoryProtocol
    
    init(repository: LogoutUserRepositoryProtocol) {
        self.repository = repository
    }
    
    func logout(_ handler: @escaping (Bool, Error?)-> ()) {
        repository.logout { (success, error) in
            if success == true {
                UserManager.shared.deleteActiveUser()
                UserManager.shared.accessToken = nil
            }
            handler(success, error)
        }
    }
    
}
