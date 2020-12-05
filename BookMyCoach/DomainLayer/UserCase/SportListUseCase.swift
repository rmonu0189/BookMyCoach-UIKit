//
//  SportListUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol SportListUseCaseProtocol {
    func fetchSportList(handler: @escaping ([Sport]?, Error?) -> ())
}

class SportListUseCase: SportListUseCaseProtocol {
    
    private let repository: SportListRepositoryProtocol
    
    init(repository: SportListRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchSportList(handler: @escaping ([Sport]?, Error?) -> ()) {
        repository.fetchSportList(handler: handler)
    }
}
