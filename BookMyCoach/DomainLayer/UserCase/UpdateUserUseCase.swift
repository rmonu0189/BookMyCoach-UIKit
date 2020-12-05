//
//  UpdateUserUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol UpdateUserUseCaseProtocol {
    func perform(request: UserUpdateRequest, handler: @escaping (User?, Error?) -> ())
}

class UpdateUserUseCase: UpdateUserUseCaseProtocol {
    
    private let repository: UpdateUserRepositoryProtocol
    
    init(repository: UpdateUserRepositoryProtocol) {
        self.repository = repository
    }
    
    func perform(request: UserUpdateRequest, handler: @escaping (User?, Error?) -> ()) {
        repository.updateUser(request: request) { (user, error) in
            if let user = user {
                UserManager.shared.activeUser = user
            }
            handler(user, error)
        }
    }
    
}
