//
//  NearbyCoachUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol NearbyCoachUseCaseProtocol {
    func nearbyCoach(latitude: Double, longitude: Double, handler: @escaping ([User]?, Error?) -> ())
}

class NearbyCoachUseCase: NearbyCoachUseCaseProtocol {
    
    private let repository: NearbyCoachRepositoryProtocol
    
    init(repository: NearbyCoachRepositoryProtocol) {
        self.repository = repository
    }
    
    func nearbyCoach(latitude: Double, longitude: Double, handler: @escaping ([User]?, Error?) -> ()) {
        let request = NearbyCoachRequest(latitude: latitude, longitude: longitude)
        repository.nearbyCoach(request, handler: handler)
    }
    
}
