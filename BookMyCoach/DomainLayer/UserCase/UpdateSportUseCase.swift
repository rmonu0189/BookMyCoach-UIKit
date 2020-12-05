//
//  UpdateSportUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol UpdateSportUseCaseProtocol {
    func updateSport(sportId: Int, isPrimary: Bool, handler: @escaping (User?, Error?) -> ())
}

class UpdateSportUseCase: UpdateSportUseCaseProtocol {
    
    private let repository: UpdateSportRepositoryProtocol
    
    init(repository: UpdateSportRepositoryProtocol) {
        self.repository = repository
    }
    
    func updateSport(sportId: Int, isPrimary: Bool, handler: @escaping (User?, Error?) -> ()) {
        repository.updateSport(sportId: sportId, isPrimary: isPrimary) { (user, error) in
            if let user = user {
                UserManager.shared.activeUser = user
            }
            handler(user, error)
        }
    }
    
}
