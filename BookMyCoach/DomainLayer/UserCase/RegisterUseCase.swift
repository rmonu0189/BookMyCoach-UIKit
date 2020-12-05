//
//  RegisterUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol RegisterUseCaseProtocol {
    func perform(email: String, password: String, userType: UserType, handler: @escaping (User?, Error?) -> ())
}

class RegisterUseCase: RegisterUseCaseProtocol {
    
    private let registerRepository: RegisterRepositoryProtocol
    
    init(repository: RegisterRepositoryProtocol) {
        self.registerRepository = repository
    }
    
    func perform(email: String, password: String, userType: UserType, handler: @escaping (User?, Error?) -> ()) {
        registerRepository.register(email: email, password: password, userType: userType) { (user, error) in
            if error == nil {
                UserManager.shared.activeUser = user
            }
            handler(user, error)
        }
    }
    
}
