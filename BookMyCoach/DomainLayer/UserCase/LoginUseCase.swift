//
//  LoginUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol LoginUseCaseProtocol {
    func perform(email: String, password: String, handler: @escaping (User?, Error?) -> ())
}

class LoginUseCase: LoginUseCaseProtocol {
    
    private let loginRepository: LoginRepositoryProtocol
    
    init(repository: LoginRepositoryProtocol) {
        self.loginRepository = repository
    }
    
    func perform(email: String, password: String, handler: @escaping (User?, Error?) -> ()) {
        loginRepository.login(email: email, password: password) { (user, error) in
            if error == nil {
                UserManager.shared.activeUser = user
            }
            handler(user, error)
        }
    }
}
