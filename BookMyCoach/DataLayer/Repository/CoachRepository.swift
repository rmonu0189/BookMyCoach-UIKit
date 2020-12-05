//
//  CoachRepository.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

class CoachRepository: NearbyCoachRepositoryProtocol {
    
    func nearbyCoach(_ request: NearbyCoachRequest, handler: @escaping ([User]?, Error?) -> ()) {
        let service = APIService.getNearbyCoaches(request: request)
        service.fetchList(User.self) { (list, error, _) in
            handler(list, error)
        }
    }
    
    func bookCoach(coachId: Int, handler: @escaping (Booking?, Error?)-> ()) {
        let service = APIService.bookCoach(request: BookCoachRequest(coachId: coachId))
        service.fetch(Booking.self) { (booking, error, _) in
            handler(booking, error)
        }
    }
    
}
